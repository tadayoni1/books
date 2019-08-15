#!/usr/bin/env bash

while getopts m: option
do
case "${option}"
in
m) TERRAFORM_MODE=${OPTARG};;
esac
done

if [ -z $TERRAFORM_MODE ]; then
  # by default it runs 'terraform apply'. With -m you can run 'terraform plan' or 'terraform destroy'
  TERRAFORM_MODE="apply"
fi

pushd terraform
terraform init -backend-config="key=state/books/eks_backend_config"

terraform ${TERRAFORM_MODE} -var-file="variables.tfvars" -var-file="../../secret.tfvars"
popd

mkdir ~/terraform-books/output/

kubeconfig=$(terraform output "kubeconfig")
config_map_aws_auth=$(terraform output "config_map_aws_auth")

echo $kubeconfig > ~/terraform-books/output/kubeconfig
echo $config_map_aws_auth > ~/terraform-books/output/config_map_aws_auth