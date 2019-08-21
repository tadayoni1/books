pipeline {
  agent any
  stages {
    stage('Install Requirements') {
      steps {
        sh '''#!/bin/bash
pip3 install --upgrade pip3
pip3 install -r python/requirements.txt
pip3 install ansible
pip3 install docker
'''
      }
    }
    stage('Test') {
      steps {
        sh '''cd python
make test'''
      }
    }
    stage('Build Docker') {
      steps {
        sh '''docker --version
docker ps
docker image ls
ansible-playbook ansible/build_docker.yml  -e "ansible_python_interpreter=/usr/bin/python3"'''
      }
    }
  }
}