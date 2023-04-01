
AWS_ACCESS_KEY_ID=$1
AWS_ACCESS_KEY_SECRET=$2

aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" --profile user2 && aws configure set aws_secret_access_key "$AWS_ACCESS_KEY_SECRET" --profile user2 && aws configure set region "ap-south-1" --profile user2 && aws configure set output "text" --profile user2