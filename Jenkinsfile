pipeline {
  agent any
  stages {
    stage('Install Requirements') {
      steps {
        sh '''#!/bin/bash
python -m pip install -r python/requirements.txt --user'''
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
        sh 'ansible-playbook ansible/build_docker.yml'
      }
    }
    stage('Push Docker') {
      steps {
        sh '''withAWS(region:\'us-west-2\', credentials: \'aws-books\') {
  ansible-playbook ansible/push_docker.yml
}'''
        }
      }
    }
  }