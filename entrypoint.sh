#!/bin/sh

# exit when any command fails
set -e

cd $WORKDIR
terraform init
terraform plan
