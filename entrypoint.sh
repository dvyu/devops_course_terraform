#!/bin/sh

# exit when any command fails
set -e

# create credentials file
(
cat << EOF
[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
EOF
) > /credentials

# run checks
cd $WORKDIR
terraform init
terraform plan
# apply
if [ "$APPLY" = "true" ];then
  echo "$SSH_PUBLIC_KEY" | base64 -d > key.pub
  cat key.pub
  terraform apply -auto-approve
  cat terraform.tfstate
  terraform output -json instance_ip_addr | jq -r '.[0]' > instance_ip_addr
  cat instance_ip_addr
  terraform output -json instance_ips | jq -r '.[0]' > instance_ips
  cat instance_ips
  cat terraform.tfstate | jq '.resources[] | select(.type == "aws_instance") | .instances[].attributes.public_ip ' > public_ip
  cat public_ip
fi
