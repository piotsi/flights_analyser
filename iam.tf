data "aws_iam_policy" "AmazonMSKFullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonMSKFullAccess"
}

resource "aws_iam_role" "role_ec2" {
  name = "role_ec2"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns = [data.aws_iam_policy.AmazonMSKFullAccess.arn]
}

data "aws_iam_policy" "AWSGlueServiceRole" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

data "aws_iam_policy" "AmazonMSKReadOnlyAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonMSKReadOnlyAccess"
}

data "aws_iam_policy" "AmazonRedshiftReadOnlyAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonRedshiftReadOnlyAccess"
}

data "aws_iam_policy" "AmazonS3FullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role" "role_glue" {
  name = "role_glue"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "glue.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns = [
    data.aws_iam_policy.AWSGlueServiceRole.arn,
    data.aws_iam_policy.AmazonMSKReadOnlyAccess.arn,
    data.aws_iam_policy.AmazonRedshiftReadOnlyAccess.arn,
    data.aws_iam_policy.AmazonS3FullAccess.arn
  ]
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.role_ec2.name
}