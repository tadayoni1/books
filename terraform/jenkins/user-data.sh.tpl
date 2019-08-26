#!/bin/bash

# Install Jenkins
sudo ucf --purge /boot/grub/menu.lst
sudo apt-get update -y
sudo UCF_FORCE_CONFFNEW=YES apt-get upgrade -y
sudo apt install -y default-jdk
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update -y
sudo apt install -y jenkins


# Install docker
sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update -y
apt-cache policy docker-ce
sudo apt install -y docker-ce

# Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Install ansible
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update -y
sudo apt-get install ansible -y
sudo apt-get install python -y

# Install docker-python
sudo apt install python-pip -y
sudo pip install docker-py

# Configure docker to run with different users
sudo groupadd docker
sudo usermod -aG docker root
sudo usermod -aG docker ubuntu
sudo usermod -aG docker jenkins
newgrp docker

# Install awscli
sudo python -m pip install awscli==1.13.0

# Install boto3
sudo apt install -y python-boto3

# Install kubectl
sudo snap install kubectl --classic

# Install aws iam authenticator
curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator
curl -o aws-iam-authenticator.sha256 https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator.sha256
openssl sha1 -sha256 aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc

# Download eks config files from s3
mkdir /var/lib/jenkins/.kube/
aws s3 cp s3://books-terraform/eks/config /var/lib/jenkins/.kube/
aws s3 cp s3://books-terraform/eks/config_map_aws_auth.yml /var/lib/jenkins/.kube/