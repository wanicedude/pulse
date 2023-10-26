resource "aws_cloudwatch_event_rule" "daily_trigger" {
  name                = "daily_event_trigger"
  description         = "Daily trigger for lambda"
  schedule_expression = "cron(*/5 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "invoke_lambda" {
  rule      = aws_cloudwatch_event_rule.daily_trigger.name
  target_id = "TriggerLambda"
  arn       = var.lambda_arn
}
