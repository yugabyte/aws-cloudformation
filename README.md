# AWS CloudFormation

This repo contains an AWS CloudFormation template to deploy YugabyteDB cluster on AWS. It does the following:
* Creates a VPC with three public subnets
* Creates an instance in each subnet
  * Note that the instances that get created use Amazon Linux 1 as the OS.
* Deploys a YugabyteDB cluster across these three nodes

# Pre-Flight Checks
- Make sure that the selected region has three or more AZs.
  - This allows this template creates 3 public subnets in three different availability zone.
- Make sure your AZ supports the instance type specified. 
- As of now, the following regions are supported by this template:
    - EU (Ireland)
    - EU (London)
    - EU (Paris)
    - EU (Frankfurt)
    - Asia Pacific (Tokyo)
    - Asia Pacific (Sydney)
    - US East (N. Virginia)
    - Asia Pacific (Singapore)
    - Asia Pacific (Mumbai) 
    - US West (Oregon)
    - US East (Ohio)

# Usage
[![Launch Stack](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://go.aws/33qDE12)


## Deploying From AWS Command Line
  - Clone this repo.
    ```
    $ git clone https://github.com/yugabyte/aws-cloudformation.git 
    ```
  - Change current directory to cloned git repo directory
  - Use aws cli to create cloudformation template <br/> 
    ```
    aws cloudformation create-stack                                             \
            --stack-name <your-stack-name>                                      \
            --template-body file://yugabyte_cloudformation.yaml                 \
            --parameters ParameterKey=DBVersion,ParameterValue=2024.2.2.1-b175    \
                         ParameterKey=KeyName,ParameterValue=<you-ssh-key-name>
    ```
  - Wait until the creation of all resources is complete.
  - Once the cloudformation stack creation is complete, you can describe it as shown below.
    ```
    $ aws cloudformation describe-stacks --stack-name <your-stack-name>
    ```
    In output you will get the VPC id and YugabyteDB admin URL.
    
## Deploying From AWS console 
  - Clone this repo.
     ```
     $ git clone https://github.com/yugabyte/aws-cloudformation.git 
     ```
  - Login to aws console and navigate to CloudFormation service dashboard.
  - Click on create stack button.
  - Select `Template is ready` in prepare template section.
  - Select `Upload a template file` in specify template section.
  - Click `choose file` button in specify template section and upload the `yugabyte_cloudforamtion.yaml` file. Click on the next button.
  -  Specify your stack name and parameters for the stack. Click on next.
  -  Add a tag to your stack and choose IAM role if required. Click on next.
  -  Review the CloudFormation stack. If everything looks good, click on create stack button. 
  -  Once stack creation gets compleated, you can access the YugabyteDB admin from URL you get in the stack output section. 
