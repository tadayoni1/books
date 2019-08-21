# books
WIP: A sample project to implement a web api in kubernetes


### Prerequisites

A workstation either local or on aws and install the following
1. terraform
2. ansible
3. docker
4. python
5. python-pip
6. docker-py
7. boto3

The workstation should either have an IAM role with EC2 and VPC access or you need to install awscli and run `aws configure` and enter credentials that have access to create EC2 and VPC resources.

#### Requirements for jenkins server
install docker.io with apt-get
install ansible with apt-get
install python3-pip with apt-get
remove pip ansible, docker and docker-py
install ansible with pip3
install docker with pip3
install awscli with apt


Web api source: https://github.com/rmotr/flask-api-example
