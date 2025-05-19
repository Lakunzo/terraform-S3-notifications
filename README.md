# S3 Bucket, SNS Notifications

## Project Overview
This project is an alert notification system that send an email to the bucket owner when an object is uploaded to an S3 bucket. It leverages Amazon S3, IAM, Lambda with Python, and SNS topics. The details of the notification include - the bucket name, file name, file size, upload date and time (UTC) and AWS account used to upload the object.

