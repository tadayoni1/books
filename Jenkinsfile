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
        sh 'ansible-playbook ansible/push_docker.yml -vvv'
      }
    }
  }
  environment {
    AWS_ACCESS_KEY_ID = credentials('jenkins-aws-secret-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    AWS_DEFAULT_REGION = 'us-west-2'
  }
}