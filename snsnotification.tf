#Create an SNS topic
resource "aws_sns_topic" "notification-topic" {
  name = var.sns-topic-name
}

#Create an SNS topic subscription
resource "aws_sns_topic_subscription" "sns-subscription" {
  topic_arn = aws_sns_topic.notification-topic.arn
  protocol = var.sns-protocol
  endpoint = var.sns-endpoint
}