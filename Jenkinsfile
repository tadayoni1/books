pipeline {
  agent any
  stages {
    stage('Install Requirements') {
      steps {
        sh '''#!/bin/bash
echo ${SHELL}
[ -d venv ] && rm -rf venv
#virtualenv --python=python2.7 venv
virtualenv venv
#. venv/bin/activate
export PATH=${VIRTUAL_ENV}/bin:${PATH}
pip3 install --upgrade pip3
pip3 install -r python/requirements.txt
pip3 list
pip list
docker --version
ansible --version
python --version
python3 --version
'''
      }
    }
    stage('Test') {
      steps {
        sh '''#. venv/bin/activate
export PATH=${VIRTUAL_ENV}/bin:${PATH}
cd python
make test'''
      }
    }
    stage('Build Docker') {
      steps {
        sh 'ansible-playbook ansible/build_docker.yml'
      }
    }
  }
  environment {
    VIRTUAL_ENV = "${env.WORKSPACE}/venv"
  }
}
