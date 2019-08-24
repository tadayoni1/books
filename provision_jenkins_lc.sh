#!/usr/bin/env bash

while getopts m: option
do
case "${option}"
in
m) TERRAFORM_MODE=${OPTARG};;
esac
done

if [ -z $TERRAFORM_MODE ]; then
  # by default it runs 'terraform apply'. With -m you can run 'terraform plan', 'terraform destroy' or 'terraform refresh'
  TERRAFORM_MODE="apply"
fi

pushd terraform/jenkins
terraform init -backend-config="key=state/books/jenkins_backend_config"

terraform ${TERRAFORM_MODE} -var-file="variables.tfvars"

popd