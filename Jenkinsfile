pipeline {
  agent {
    docker {
      image 'postman/newman:alpine'
      args '-v $WORKSPACE:/etc/newman'
    }
  }
}


  stages {
    stage('Build') {
      steps {
        echo 'Building...'
      }
    }

    stage('Test') {
      steps {
        echo 'Running API tests...'
        sh 'newman run api_automation_karobar.json -e karobar.json --reporters cli'
      }
    }
  }

