# AWS CloudFormation

A CloudFormation template to deploy YugaByte DB cluster on AWS. It will create a VPC with three public subnets with one YugaByte node in each subnet. 

# Usage
- # For AWS Command Line
  - First, git clone the repo. <br/>
     ``
        $ git clone https://github.com/YugaByte/yugabytedb-cloudformation.git
    ``    
  - change current directory to cloned git repo directory
  - Use aws cli to create cloudformation template <br/> 
    `` $ aws cloudformation create-stack 
            --stack-name <your-stack-name> 
            --template-body yugabyte_cloudformation.yaml 
            --parameters DBVersion=1.2.8.0,
                      KeyName=<you-ssh-key-name>
    ``
  - Wait till all resource creation get complete.
  - Once cloudformation stack get completed we can see output using folwing comand. <br/>
    ``
        $ aws cloudformation describe-stacks --stack-name <your-stack-name>
    ``  
    In output you will get the VPC id and YugabByte DB admin URL. 
- # For AWS console 
  - First, git clone the repo. <br/>
     ``
        $ git clone https://github.com/YugaByte/yugabytedb-cloudformation.git
    ``
  - Login to aws console and navigate to CloudFormation service dashboard.
  - Click on create stack button.
  - Select 'Template is ready' in Prepare template section and select 'upload a template file ' in Specify template section.
  - Now click on 'choose file' button in specify template section and upload the **yugabyte_cloudforamtion.yaml** file and click on next button.
  -  Specify your stack name and parameters for the stack and click on next.
  -  Add a tag to your stack and choose IAM role if required and click on next.
  -  Review the CloudFormation stack and click on create stack button. 
  -  Once stack creation gets compleated, you can access the YugaByte DB admin from URL you get in the stack output section. 
 

# Limitations
- As of now, we are supporting Amazon Linux 1 for YugaByte DB.
- The selected region must have availability zone three or more because this template creates 3 public subnets in three different availability zone.
- Make sure your availability zone support the instance type you selected for your YugaByte DB node. 
- Right now following region is supported by this template. 
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