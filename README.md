# books
A sample project to implement a web api in kubernetes.

This project first deploys a Kubernetes cluster in AWS.
Then a Jenkins pipeline lints the python web api application in the python folder, containerizes it, and uploads it to AWS ECR. After that it deploys the application to AWS EKS with a rolling update strategy.


### Prerequisites

1. A workstation(automation server) either local or on aws and install Terraform on it.
  - The workstation should either have an IAM role with EC2 and VPC access or you need to install awscli and run `aws configure` and enter credentials that have access to create EC2 and VPC resources.
2. Checkout the code to the automation server
3. In parent directory of the code folder create a file named `secret.tfvars` and enter the IP's which you want to limit eks access to.
  - `my_workstations_ip = ["1.2.3.4/32", "5.6.7.8/32"]`

### Deployment Steps
1. First we need to deploy an EKS cluster to AWS. It is done by terraform. 
  - run `./provision_eks.sh`
2. We need to deploy a jenkins server and then configure it. A launch template can be created by terraform that installs all the requirements for jenkins server to run the pipeline.
- run `./provision_eks_lc.sh`
- after jenkins is running configure it and install all recommended plugins.
- create following creadentials in form of a secret text in jenkins
  - jenkins-aws-secret-key-id
  - jenkins-aws-secret-access-key
- run `sudo systemctl restart jenkins` so jenkins can connect to docker


### Jenkins Pipeline
After Kubernetes cluster is deployed and jenkins server is ready and configured, connect jenkins to the github repo and run the pipeline.

Web api source: https://github.com/rmotr/flask-api-example
