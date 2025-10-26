pipeline {
  agent any

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
}
