pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-creds')
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/coder-0626/Task-m18.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                bat '''
                docker build -t milind0626/sample-web-app:latest .
                '''
            }
        }
        stage('Push Docker Image') {
            steps {
                bat '''
                echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
                docker push milind0626/sample-web-app:latest
                '''
            }
        }
    }
}
