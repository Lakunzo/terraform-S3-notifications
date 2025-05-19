resource "aws_iam_role" "iam-role" {
  name = "s3-sns-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
        Action = "sts:AssumeRole",
        Principal = {
            Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid = ""
    }]
  })
}

resource "aws_iam_policy" "role-policy" {
  name = "s3-sns-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
            Action = [
                "logs:CreateLogFroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            Effect = "Allow",
            Resource = "arn:aws:logs:*:*:*"
        },
        {
            Action = [
                "sns:Publish"
            ],
            Effect = "Allow",
            Resource = aws_sns_topic.notification-topic.arn
        },
        {
            Action = [
                "s3:GetObject",
                "s3:PutObject",
                "s3:ListBucket",
                "s3:DeleteObject"
            ],
            Effect = "Allow",
            Resource = ["${aws_s3_bucket.mainbucket.arn}/*",
            "${aws_s3_bucket.mainbucket.arn}"]
        }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "role-policy-attach" {
  role = aws_iam_role.iam-role.name
  policy_arn = aws_iam_policy.role-policy.arn
}