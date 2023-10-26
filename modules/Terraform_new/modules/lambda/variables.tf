variable "iam_role" {
  description = "The IAM role to use for the lambda function"
  type        = string
}

variable "events_rule_arn" {
  description = "The ARN of the CloudWatch Events rule to use for the lambda function"
  type        = string

}