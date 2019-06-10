# ASG with ELB Example

This is an example of how to use Terraform to deploy an [Auto Scaling Group (ASG)](https://aws.amazon.com/autoscaling/) 
with an [Elastic Load Balancer (ELB)](https://aws.amazon.com/elasticloadbalancing/) in front of it. To keep the example 
simple, we deploy a vanilla Ubuntu AMI across the ASG and we run a dirt simple "web server" on top of it as a [User 
Data](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html) script. The "web server" always 
returns "Hello, World". See the [root README](/README.md) for instructions on how to run this example code. 

Note: This code is meant solely as a simple demonstration of how to lay out your files and folders with 
[Terragrunt](https://github.com/gruntwork-io/terragrunt) in a way that keeps your [Terraform](https://www.terraform.io) 
code DRY. This is not production-ready code, so use at your own risk.
