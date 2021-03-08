pipeline {
  agent any

  environment{
    CHECK_URL = "http://localhost:1912"
  }

  options {
    timeout(time: 60, unit: "MINUTES")
  }
  stages {
    stage('Build jupiter and filebrowser') {
      steps {
        sh 'ci/build-docker-images.sh'
      }
    }
    stage('Start CPU') {

      steps {
        script {
          Exception caughtException = null

          catchError(buildResult: 'SUCCESS', stageResult: 'ABORTED') {
            try {
              sh 'ci/run.sh cpu'
              return true
            } catch (Throwable e) {
              caughtException = e
            }
          }

          if (caughtException) {
            error caughtException.message
          }
        }
      }
    }

    stage('Start GPU') {

      steps {
        script {
          Exception caughtException = null

          catchError(buildResult: 'SUCCESS', stageResult: 'ABORTED') {
            try {
              sh 'ci/run.sh gpu'
              return true
            } catch (Throwable e) {
              caughtException = e
            }
          }

          if (caughtException) {
            error caughtException.message
          }
        }
      }
    }

  }
}
