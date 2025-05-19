import boto3
import os
from datetime import datetime

sns = boto3.client('sns')
s3 = boto3.client('s3')

SNS_TOPIC_ARN = os.environ['SNS_TOPIC_ARN']

def lambda_handler(event, context):
    print("Event received:", event)

    try:
        record = event['Records'][0]
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        size = record['s3']['object']['size']
        event_time = record['eventTime']  # ISO 8601 format
        uploader_account = record['userIdentity']['principalId'].split(':')[0]  # AWS account ID
    except (KeyError, IndexError) as e:
        print("Error parsing event structure:", e)
        raise

    # Optional: Convert timestamp to readable format
    timestamp = datetime.strptime(event_time, "%Y-%m-%dT%H:%M:%S.%fZ")
    readable_time = timestamp.strftime('%Y-%m-%d %H:%M:%S UTC')

    # Message body
    subject = "📂 New File Uploaded to S3"
    message = (
        f"A new object has been uploaded to your S3 bucket.\n\n"
        f"🪣 Bucket: {bucket}\n"
        f"📄 Key: {key}\n"
        f"📏 Size: {size} bytes\n"
        f"🕒 Upload Time: {readable_time}\n"
        f"👤 Uploaded By (AWS Account ID): {uploader_account}\n\n"
        f"🔗 You can view the object in the AWS S3 Console (if permissions allow)."
    )

    try:
        response = sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Subject=subject,
            Message=message
        )
        print("SNS message sent. Message ID:", response['MessageId'])
    except Exception as e:
        print("Error sending SNS message:", e)
        raise

    return {
        'statusCode': 200,
        'body': f"SNS notification sent for file: {key}"
    }
