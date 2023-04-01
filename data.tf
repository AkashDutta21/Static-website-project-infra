# Get the IAM role by name
data aws_iam_policy "requied_role" {
  name = "AmazonS3FullAccess"
}