data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_ssm_parameter" "al2023_arm64" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-arm64"  
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "app_runtime" {
  statement {
    sid     = "Read"
    actions = ["secretsmanager:GetSecretValue"]
    resources = [module.database.db_master_secret_arn]
  }

  statement {
    sid     = "WriteRuntimeReports"
    actions = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.runtime.arn}/reports/*"]
  }
}
