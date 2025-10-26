pipeline {
    agent any

    environment {
        COLLECTION = 'api_automation_karobar.json'
        ENVIRONMENT = 'karobar.json'
        REPORT_DIR = 'newman-reports'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install -g newman newman-reporter-htmlextra'
            }
        }

        stage('Run API Tests') {
            steps {
                sh '''
                    mkdir -p ${REPORT_DIR}
                    newman run ${COLLECTION} \
                    -e ${ENVIRONMENT} \
                    --reporters cli,htmlextra \
                    --reporter-htmlextra-export ${REPORT_DIR}/karobar-report.html \
                    --insecure
                '''
            }
        }

        stage('Publish Report') {
            steps {
                publishHTML([
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: "${REPORT_DIR}",
                    reportFiles: 'karobar-report.html',
                    reportName: 'Karobar API Automation Report'
                ])
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'newman-reports/*.html', fingerprint: true
        }
        failure {
            echo '❌ Some API tests failed. Check the HTML report for details.'
        }
        success {
            echo '✅ All API tests passed successfully!'
        }
    }
}
