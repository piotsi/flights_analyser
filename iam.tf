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

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.role_ec2.name
}