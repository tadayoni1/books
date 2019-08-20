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
pip install --upgrade pip
pip install -r python/requirements.txt
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
  }
  environment {
    VIRTUAL_ENV = "${env.WORKSPACE}/venv"
  }
}