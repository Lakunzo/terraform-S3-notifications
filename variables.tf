variable "aws-access-key" {
  description = "Access key required for programmatic access"
  default = ""
}

variable "aws-secret-key" {
  description = "Secret key required for programmatic access"
  default = ""
}

variable "aws-token-key" {
  description = "Token key required for programmatic access"
  default = ""
}

variable "s3-bucket-tags" {
  description = "Tags for unique identification of S3 buckets"
  type = map(string)
  default = {
    "Stack" = "Production"
    "Cost Center" = ""
    "Owner" = ""
    "Department" = ""
  }
}

variable "kms-key-tags" {
  type = map(string)
  description = "Tags assigned to kms keys"
  default = {
    "Department" = "value"
    "Buckets" = ""
  }
}

variable "block-public-acls" {
  type = bool
  default = true
}

variable "block-public-policy" {
 type = bool
 default = true 
}

variable "ignore-public-acls" {
  type = bool
  default = true
}

variable "restrict-public-buckets" {
  type = bool
  default = true
}

variable "enable-key-rotations" {
  type = bool
  default = true
}

variable "key-deletion-windows-days" {
  type = number
  default = 25
}

variable "sns-topic-name" {
  description = "Name for SNS topic"
  default = "dept-bucket-topic"
}

variable "sns-protocol" {
  description = "Protocol used by SNS"
  default = "email"
}

variable "sns-endpoint" {
  description = "Email endpoint to recieve notifications"
  default = ""
}