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

pushd terraform
terraform init -backend-config="key=state/books/eks_backend_config"

terraform ${TERRAFORM_MODE} -var-file="variables.tfvars" -var-file="../../secret.tfvars"

if [ $TERRAFORM_MODE == 'apply' ]; then
mkdir ~/terraform-books/
mkdir ~/terraform-books/output/
$(terraform output "kubeconfig" > ~/terraform-books/output/kubeconfig)
$(terraform output "config_map_aws_auth" > ~/terraform-books/output/config_map_aws_auth)
fi
popd
