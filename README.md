# Example infrastructure-live for Terragrunt

This repo, along with the [terragrunt-infrastructure-modules-example 
repo](https://github.com/gruntwork-io/terragrunt-infrastructure-modules-example), show an example file/folder structure
you can use with [Terragrunt](https://github.com/gruntwork-io/terragrunt) to keep your 
[Terraform](https://www.terraform.io) code DRY. For background information, check out the [Keep your Terraform code
DRY](https://github.com/gruntwork-io/terragrunt#keep-your-terraform-code-dry) section of the Terragrunt documentation.

This repo shows an example of how to use the modules from the `terragrunt-infrastructure-modules-example` repo to 
deploy an Auto Scaling Group (ASG) and a MySQL DB across three environments (qa, stage, prod) and two AWS accounts 
(non-prod, prod), all without duplicating any of the Terraform code. That's because there is just a single copy of 
the Terraform code, defined in the `terragrunt-infrastructure-modules-example` repo, and in this repo, we solely define
`terraform.tfvars` files that reference that code (at a specific version, too!) and fill in variables specific to each 
environment. 

Note: This code is solely for demonstration purposes. This is not production-ready code, so use at your own risk. If 
you are interested in battle-tested, production-ready Terraform code, check out [Gruntwork](http://www.gruntwork.io/).




## How do you deploy the infrastructure in this repo?

Pre-requisites: 

1. Install [Terraform](https://www.terraform.io/) and [Terragrunt](https://github.com/gruntwork-io/terragrunt).
1. Update the `bucket` parameter in `non-prod/terraform.tfvars` and `prod/terraform.tfvars` to unique names. We use S3
   [as a Terraform backend](https://www.terraform.io/docs/backends/types/s3.html) to store your Terraform state, and
   S3 bucket names must be globally unique. The names currently in the file are already taken, so you'll have to 
   specify your own.
1. Configure your AWS credentials using one of the supported [authentication 
   mechanisms](https://www.terraform.io/docs/providers/aws/#authentication).

To deploy a single module:    

1. `cd` into the module's folder (e.g. `cd non-prod/us-east-1/qa/mysql`).    
1. Run `terragrunt plan` to see the changes you're about to apply.
1. If the plan looks good, run `terragrunt apply`.

To deploy everything in a single account:

1. `cd` into the account folder (e.g. `cd non-prod`).
1. Run `terragrunt plan-all` to see all the changes you're about to apply.
1. If the plan looks good, run `terragrunt apply-all`.





## How is the code in this repo organized?

The code in this repo uses the following folder hierarchy:
 
```
account
 └ _global
 └ region
    └ _global
    └ environment
       └ resource
```

Where:

* **Account**: At the top level are each of your AWS accounts, such as `stage-account`, `prod-account`, `mgmt-account`, 
  etc. If you have everything deployed in a single AWS account, there will just be a single folder at the root (e.g. 
  `main-account`).
  
* **Region**: Within each account, there will be one or more [AWS 
  regions](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html), such as 
  `us-east-1`, `eu-west-1`, and `ap-southeast-2`, where you've deployed resources. There may also be a `_global` 
  folder that defines resources that are available across all the AWS regions in this account, such as IAM users, 
  Route 53 hosted zones, and CloudTrail. 

* **Environment**: Within each region, there will be one or more "environments", such as `qa`, `stage`, etc. Typically, 
  an environment will correspond to a single [AWS Virtual Private Cloud (VPC)](https://aws.amazon.com/vpc/), which 
  isolates that environment from everything else in that AWS account. There may also be a `_global` folder 
  that defines resources that are available across all the environments in this AWS region, such as Route 53 A records, 
  SNS topics, and ECR repos.
  
* **Resource**: Within each environment, you deploy all the resources for that environment, such as EC2 Instances, Auto
  Scaling Groups, ECS Clusters, Databases, Load Balancers, and so on. Note that the Terraform code for most of these
  resources lives in the [terragrunt-infrastructure-modules-example 
  repo](https://github.com/gruntwork-io/terragrunt-infrastructure-modules-example).