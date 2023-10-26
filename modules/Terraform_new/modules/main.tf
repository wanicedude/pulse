#Configure Backend(S3 Bucket and DynamoDB)
terraform {
  backend "s3" {
    bucket                  = "bucketname"
    key                     = "objectkey"
    region                  = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
    dynamodb_table          = "Dynamodbtablename"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


module "iamrole" {
  source = "./modules/iamrole"
}

module "lambda" {
  source          = "./modules/lambda"
  iam_role        = module.iamrole.iam_role
  events_rule_arn = module.eventbridge.daily_trigger
}

module "eventbridge" {
  source     = "./modules/eventbridge"
  lambda_arn = module.lambda.lambda_arn
}