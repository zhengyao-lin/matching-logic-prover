pipeline {
  agent {
    dockerfile {
      additionalBuildArgs '--build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g)'
    }
  }
  stages {
    stage("Init title") {
      when { changeRequest() }
      steps {
        script {
          currentBuild.displayName = "PR ${env.CHANGE_ID}: ${env.CHANGE_TITLE}"
        }
      }
    }
    stage('Build Z3') {
      steps {
        ansiColor('xterm') {
          sh '''#!/bin/bash
            cd prover && ./build .build/local/bin/z3
          '''
        }
      }
    }
    stage('Test') {
      steps {
        ansiColor('xterm') {
          sh '''#!/bin/bash
            cd prover && ./build
          '''
        }
      }
    }
  }
}
