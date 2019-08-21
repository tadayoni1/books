pipeline {
  agent any
  stages {
    stage('Install Requirements') {
      steps {
        sh '''#!/bin/bash
pip3 install --upgrade pip3
pip3 install -r python/requirements.txt
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
        sh 'ansible-playbook ansible/build_docker.yml  -e "ansible_python_interpreter=/usr/bin/python3"'
      }
    }
  }
}
