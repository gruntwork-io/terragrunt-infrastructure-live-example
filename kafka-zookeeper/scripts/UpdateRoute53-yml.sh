#!/bin/bash

echo "Running UpdateRoute53.sh"
stackName=$1
#stackName=sai-test

yum install epel-release -y
curl -O https://bootstrap.pypa.io/get-pip.py
export PATH=~/.local/bin:$PATH
python get-pip.py --user
pip install awscli --upgrade --user
pip install boto

yum install ansible --enablerepo=epel -y

echo stackName \'$stackName\'

#ec2_tag_key=Couchbase-Cluster
#ec2_tag_value=${stackName}


## AWS region
region=$2
#region=us-west-1

## Route53 zone name and record name
zone_name=$3
rec_name=$4
#zone_name=sai-test.com
#rec_name=test.sai-test.com

## Ec2-tag
ec2_tag_key=$5
#ec2_tag_key=Name
###-Server and ServerRally covered in value
ec2_tag_value=$6
#ec2_tag_value=${stackName}-Server*
#ec2_tag_value=Couchbase-${stackName}-Server*


## AWS VPC ID
vpc_id=$7
#vpc_id=vpc-e80a6180


## Making Inventory file
my_inventory=myhosts
cat > /${my_inventory} <<EOF
[localhost]
localhost ansible_connection=local ansible_python_interpreter=python
EOF

## Printing Variable values
echo "==========================="
echo -e "zone_name=$zone_name \nRegion=$region \nRecorName=$rec_name \nec2_tag_key=$ec2_tag_key \nec2_tag_value=$ec2_tag_value"
echo "==========================="

## Creating Yaml file
cat > /route53.yml <<EOF
---
- hosts: localhost
  vars:
       - REGION: ${region}
       - vpc_id: ${vpc_id}
       - zone_name: ${zone_name}
       - rec_name: ${rec_name}
       - ec2_tag_key: ${ec2_tag_key}
       - ec2_tag_value: ${ec2_tag_value}

  tasks:
   - name: sleep for 4 seconds and continue with play
     wait_for: timeout=4

   - name: Collecting Private IP address
     shell: "aws --region {{REGION}} ec2 describe-instances --filters \"Name=tag:{{ec2_tag_key}},Values={{ec2_tag_value}}\" \"Name=network-interface.addresses.private-ip-address,Values=*\" --query 'Reservations[*].Instances[*].{InstanceId:InstanceId,PrivateDnsName:PrivateDnsName,State:State.Name, IP:NetworkInterfaces[0].PrivateIpAddress}'|grep -w IP|awk '{print \$2}'|tr -d ','|tr -d '\"'"
     register: private_ips

   - set_fact: private_ip="{{private_ip|default([])+[item]}}"
     with_items: "{{ private_ips.stdout_lines }}"

   - name: create a private zone
     route53_zone:
      zone: "{{zone_name}}"
      vpc_id: '{{ vpc_id }}'
      vpc_region: "{{REGION}}"
      comment: Managed by CloudFormation

   - name: Updatading route 53 with new module
     route53:
      command: create
      overwrite: true
      private_zone: true
      zone: "{{zone_name}}"
      record: "{{rec_name}}"
      type: A
      ttl: 30
      value: "{{private_ips.stdout_lines}}"
      #value: "{{private_ip}}"
     register: status_result
     ignore_errors: true

   - name: Updatading route 53 with old module
     route53:
      state: present
      overwrite: true
      private_zone: true
      zone: "{{zone_name}}"
      record: "{{rec_name}}"
      type: A
      ttl: 30
      value: "{{private_ips.stdout_lines}}"
      #value: "{{private_ip}}"
     when: status_result is failed


   - cron:
       name: "a job for reboot"
       special_time: reboot
       job: "ansible-playbook -i /${my_inventory} /route53.yml -vv > /route53-cron.log"


EOF
## Playing playbook to update Route53
ansible-playbook -i /${my_inventory} /route53.yml -vv

