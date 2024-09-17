pipeline {
    agent any
    stages {
        stage('Cleanup Previous Containers') {
            steps {
                sh 'docker stop ic-webapp || true'
                sh 'docker rm ic-webapp || true'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ic-webapp:1.0 .'
            }
        }
        stage('Run Docker Container') {
            steps {
                sh 'docker run -d --name ic-webapp -p 80:8080 ic-webapp:1.0'
            }
        }
        stage('Wait for Application') {
            steps {
                script {
                    retry(5) {
                        sh 'sleep 10' // Wait for 10 seconds before each retry
                        sh 'curl http:127.0.0.1:80'  // Use port 8000 for curl
                    }
                }
            }
        }
        stage('Send HTTP Request') {
            steps {
                httpRequest url: 'http:127.0.0.1:80'  // Use port 8000 for httpRequest
            }
        }
    }
}

