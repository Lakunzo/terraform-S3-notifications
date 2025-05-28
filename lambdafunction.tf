#Creates a lambda function with an environment variable to securely hold SNS topic ARN
resource "aws_lambda_function" "lambda-function" {
  filename = "lambdanotify.zip"
  function_name = "s3-bucket-trigger"
  role = aws_iam_role.iam-role.arn
  handler = "lambdanotify.lambda_handler"
  runtime = "python3.13"

  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.notification-topic.arn
    }
  }
}