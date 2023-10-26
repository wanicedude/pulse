resource "aws_iam_role" "CilprojLambdaRole" {
  name = "CilprojLambdaRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
      },
    ]
  })

  tags = {
    tag-key = "CillambdaRole"
    
  }
}

#policy for the role
resource "aws_iam_policy" "lambda_s3_policy" {
  name        = "LambdaS3DumpPolicy"
  description = "Allows Lambda to dump data into an S3 bucket."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        Resource = "arn:aws:s3:::bucketarn/*",
        Effect   = "Allow",
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_s3_attach" {
  role       = aws_iam_role.CilprojLambdaRole.name
  policy_arn = aws_iam_policy.lambda_s3_policy.arn
}

