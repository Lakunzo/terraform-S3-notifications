# Create an S3 Bucket with KMS Key, Lambda, and SNS Notifications

## Project Overview
This project is an alert notification system that send an email to the bucket owner when an object is uploaded to an S3 bucket. It leverages Amazon S3, IAM, Lambda with Python, and SNS topics. The details of the notification include - the bucket name, file name, file size, upload date and time (UTC) and AWS account used to upload the object.

![Archtiectural Diagram](https://i.postimg.cc/zDRyc6Fw/s3notification-drawio.png)

## Technologies Used
* Cloud Provider - AWS
* Services Used - S3 bucket, IAM, Lambda, SNS
* Programming Language - Python 3.11

## Setup Guide
### Clone the Repository
```bash
git clone https://github.com/Lakunzo/terraform-S3-notifications.git
```
### Modify the variables.tf and iamrole.tf
#### Variables.tf
Make changes to the following variables
* aws-access-key - aws access key for programmatic functions
* aws-secret-key - aws secret key for programmatic functions
* aws-token-key (Optional) - aws token key for programmatic functions
* sns-endpoint - email to subecribe and receive notifications

### Keymanagement.tf
* AWS Principal - to allow access to the account and user ID with permissions to create and administer KMS keys

### Run the following Terraform commands
1. Initialize Terraform backend
```Bash
terraform init
```
2. Validate the Terraform configuration
```Bash
terraform validate
```
3. Run the Terraform plan to view the resources that will be created
```Bash
terraform plan
```
4. Run Terraform apply to create the needed resources and type 'yes' to proceed
```Bash
terraform apply
```
5. Confirm if you have the following resources created
    * An S3 bucket with SSE-KMS keys, and an event notification.
    * An SSE-KMS Key attached to the S3 bucket
    * A Lambda function with a Python code
    * An SNS topics with a subscription sent to the configured email address
    * An IAM role with required permission policies
### Confirm SNS Subscription
Click the link in the email to confirm the SNS subscription.
![Subscription Email](https://i.postimg.cc/3Nfpys63/Screenshot-2025-05-19-162450.png)

### Upload an object to test notification
Upload an object to the S3 bucket to test the email notification
![Notification Email](https://i.postimg.cc/QdDRMvp2/Screenshot-2025-05-19-163133.png)

6. Run Terraform destroy to remove all created resources. Type 'yes' to proceed
````Bash
terraform destroy
````




