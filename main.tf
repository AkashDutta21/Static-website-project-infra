provider aws {
    region = var.region
    profile = var.profile
}

# Create IAM role
resource "aws_iam_role" "allow-s3-access" {
  name = "allow-s3-access"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
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
}

# attach the policy to the role
resource "aws_iam_role_policy_attachment" "attach-s3" {
    role = aws_iam_role.allow-s3-access.name
    policy_arn =  data.aws_iam_policy.requied_role.arn
}

# create an instance profile
resource "aws_iam_instance_profile" "ec2-s3-profile" {
  name = "ec2-s3-profile"
  role = aws_iam_role.allow-s3-access.name
}

# create an ec2 instance and attach the instance profile
resource "aws_instance" "tf_server" {
  ami                     = "ami-02eb7a4783e7e9317"
  instance_type           = "t2.micro"
  vpc_security_group_ids  = ["sg-0d7bcc203d5ab3971"]
  iam_instance_profile    = aws_iam_instance_profile.ec2-s3-profile.name
  tags = {
    Name = "Terraform Runner"
  }
}

