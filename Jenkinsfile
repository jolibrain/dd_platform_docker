pipeline {
  agent any

  environment{
    CHECK_URL = "http://localhost:1912"
  }

  stages {
    stage('Start CPU') {
      steps {
        waitUntil {
          try {
            sh '''export DD_PLATFORM=$PWD
            cd code/cpu/
            CURRENT_UID=$(id -u):$(id -g) MUID=$(id -u) docker-compose up -d
            curl -s --head --request GET localhost:1912 | grep 200'''
            return true
          } catch (Exception e) {
            return false
          }
        }
      }
    }
    stage('Start GPU') {
      steps {
        waitUntil {
          try {
            sh '''export DD_PLATFORM=$PWD
            cd code/gpu/
            CURRENT_UID=$(id -u):$(id -g) MUID=$(id -u) docker-compose up -d
            curl -s --head --request GET localhost:1912 | grep 200'''
            return true
          } catch (Exception e) {
            return false
          }
        }
      }
    }
  }
}
