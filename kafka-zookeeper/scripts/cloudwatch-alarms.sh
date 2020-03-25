#!/usr/bin/env bash
#===========================================================================================================================
#
# FILE: create-cloudwatch-alarms.sh
# Pre-requisite - Disk and Mem Utlization Custom metrices should be implemented first in order to create Alarm on them.
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mon-scripts.html
# DESCRIPTION: Script creates 4 alarms for instance with PRIVATE_IP
# It does follow steps:
# 1. Creates high cpu usage alarm
# 2. Creates instance statusCheck alarm
# 3. Create Alarm to check disk utilization
# 4. Create Alarm on Memory utilization
#============================================================================================================================

echo "Running cloudwatch-alarms.sh"
envVar=$1

if [ "${envVar}" = "Pre-prod" ]
then
echo "Getting Instance ID and name tag..."

# Get instance id and name tag
export EC2_HOME=/opt/aws/apitools/ec2
export JAVA_HOME=/usr/
PRIVATE_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
INSTANCE_NAME=$(/opt/aws/bin/ec2-describe-tags --region $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone  | sed -e "s/.$//")    --filter      resource-id=$(curl --silent http://169.254.169.254/latest/meta-data/instance-id) | head -1 | awk '{print $5}')

echo "${PRIVATE_IP}" | grep -q -E "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$"

if [ $? -ne 0 ]
then
    echo "### Usage: $0 $PRIVATE_IP"
    echo "### IP address have to be presented in format X.X.X.X"
    exit 1
fi

# Trying auto-detect AWS region
AWS_DEFAULT_REGION=$(curl -s --connect-timeout 2 http://169.254.169.254/latest/meta-data/placement/availability-zone | sed -e 's/\([1-9]\).$/\1/g')

# Export environment variables for awscli
export AWS_DEFAULT_REGION
export AWS_DEFAULT_OUTPUT="text"

#if [ "${INSTANCE_NAME}" = "None" ]
#then
#    echo "### Could not find instance with IP ${PRIVATE_IP}"
#    exit 1
#fi

echo "Using variables:"
echo envVar \'$envVar\'
# 1) Create high CPU usage metric
ARN_OF_SNS_TOPIC="arn:aws:sns:us-west-2:953030164212:SNS"
CPU_USAGE=70

aws cloudwatch put-metric-alarm \
    --alarm-name "${INSTANCE_ID}-${INSTANCE_NAME}-cpu"\
    --alarm-description "Alarm when CPU exceeds ${CPU_USAGE}%"\
    --actions-enabled\
    --ok-actions "${ARN_OF_SNS_TOPIC}"\
    --alarm-actions "${ARN_OF_SNS_TOPIC}"\
    --insufficient-data-actions "${ARN_OF_SNS_TOPIC}"\
    --metric-name CPUUtilization\
    --namespace AWS/EC2\
    --statistic Average\
    --dimensions  Name=InstanceId,Value=${INSTANCE_ID}\
    --period 60\
    --threshold ${CPU_USAGE}\
    --comparison-operator GreaterThanThreshold\
    --evaluation-periods 15\
    --unit Percent

# 2) Create status check metric
aws cloudwatch put-metric-alarm \
    --alarm-name "${INSTANCE_ID}-${INSTANCE_NAME}-status"\
    --alarm-description "Alarm when statusCheck failed"\
    --actions-enabled\
    --ok-actions "${ARN_OF_SNS_TOPIC}"\
    --alarm-actions "${ARN_OF_SNS_TOPIC}"\
    --insufficient-data-actions "${ARN_OF_SNS_TOPIC}"\
    --metric-name StatusCheckFailed\
    --namespace AWS/EC2\
    --statistic Maximum\
    --dimensions  Name=InstanceId,Value=${INSTANCE_ID}\
    --period 60\
    --threshold 1\
    --comparison-operator GreaterThanOrEqualToThreshold\
    --evaluation-periods 15\
    --unit Count

# 3) Create Alarm to check disk utilization
aws cloudwatch put-metric-alarm \
    --alarm-name "${INSTANCE_ID}-${INSTANCE_NAME}-Disk-Utl"\
    --alarm-description "Alarm when Disk usage exceed 85 percent"\
    --actions-enabled \
    --ok-actions "${ARN_OF_SNS_TOPIC}"\
    --alarm-actions "${ARN_OF_SNS_TOPIC}"\
    --insufficient-data-actions "${ARN_OF_SNS_TOPIC}"\
    --metric-name DiskSpaceUtilization\
    --namespace System/Linux \
    --statistic Maximum\
    --dimensions  Name=InstanceId,Value=${INSTANCE_ID} Name=MountPath,Value=/ Name=Filesystem,Value=/dev/xvda1\
    --period 60\
    --threshold 85\
    --comparison-operator GreaterThanOrEqualToThreshold\
    --evaluation-periods 15\
    --unit Percent
# 4) Creat Alarm on Memory utilization


aws cloudwatch put-metric-alarm \
    --alarm-name "${INSTANCE_ID}-${INSTANCE_NAME}-Mem-Utl"\
    --alarm-description "Alarm when Memory usage exceed 85 percent"\
    --actions-enabled \
    --ok-actions "${ARN_OF_SNS_TOPIC}"\
    --alarm-actions "${ARN_OF_SNS_TOPIC}"\
    --insufficient-data-actions "${ARN_OF_SNS_TOPIC}"\
    --metric-name MemoryUtilization\
    --namespace System/Linux \
    --statistic Maximum\
    --dimensions  Name=InstanceId,Value=${INSTANCE_ID}\
    --period 60\
    --threshold 85\
    --comparison-operator GreaterThanOrEqualToThreshold\
    --evaluation-periods 15\
    --unit Percent
    
echo "CloudWatch Alarm Setup completed on $envVar"    
else
echo "$envVar does not require CloudWatch Alarms"
fi
