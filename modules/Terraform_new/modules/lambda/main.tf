resource "aws_lambda_function" "twitterpull_lambda" {
  function_name = "twitterpullfunction"
  role          = var.iam_role
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  filename         = "lambdaDeploymentPackage.zip"
  timeout = 60
  memory_size = 128

  #Associate the layer with the function
  layers = [aws_lambda_layer_version.twitterpull_layer.arn]

}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id = "AllowEventBridge"
  action       = "lambda:InvokeFunction"

  depends_on = [aws_lambda_function.twitterpull_lambda]

  function_name = aws_lambda_function.twitterpull_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.events_rule_arn
}


resource "aws_lambda_layer_version" "twitterpull_layer" {
  filename   = "twitter_layer.zip"
  layer_name = "twitter_layer"

source_code_hash = filebase64sha256("twitter_layer.zip")

  compatible_runtimes = ["python3.11"]
}
