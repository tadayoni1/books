pipeline {
  agent any
  environment {
      VIRTUAL_ENV = "${env.WORKSPACE}/venv"
  }
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
  }
}
