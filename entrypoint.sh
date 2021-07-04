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
  terraform apply -auto-approve
fi
