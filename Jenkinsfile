pipeline {
  agent any
  stages {
    stage('Install Requirements') {
      steps {
        sh '''#!/bin/bash
python -m pip uninstall pip
pip install -r python/requirements.txt'''
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
        sh 'ansible-playbook ansible/build_docker.yml -e "ansible_python_interpreter=/usr/bin/python3"'
      }
    }
    stage('Push Docker') {
      steps {
        sh 'ansible-playbook ansible/push_docker.yml -e "ansible_python_interpreter=/usr/bin/python3"'
      }
    }
  }
}