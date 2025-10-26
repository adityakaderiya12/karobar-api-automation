pipeline {
  agent any

  stages {
    stage('Test') {
      steps {
        sh 'newman run api_automation_karobar.json -e karobar.json --reporters cli,html --reporter-html-export newman-report.html'
      }
    }
  }

  post {
    always {
      archiveArtifacts artifacts: 'newman-report.html', followSymlinks: false
    }
  }
}
