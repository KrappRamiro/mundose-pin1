pipeline {
    agent any
    environment {
        NEXUS_CREDS = credentials('nexus_creds')
        NEXUS_DOCKER_REPO = '127.0.0.1:8082'
    }
    stages {
        stage('Building image') {
            steps {
                sh '''
          docker build -t webapp -t $NEXUS_DOCKER_REPO/webapp:latest -f webapp.Dockerfile .
          '''
            }
        }
        stage('Docker Login') {
            steps {
                echo 'Nexus Docker Repository Login'
                script {
                    withCredentials([usernamePassword(credentialsId: 'nexus_creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                        sh ' echo $PASS | docker login -u $USER --password-stdin $NEXUS_DOCKER_REPO'
                    }
                }
            }
        }
        stage('Docker Push') {
            steps {
                echo 'Pushing Image to docker hub'
                sh 'docker push $NEXUS_DOCKER_REPO/webapp:latest'
            }
        }
    }
}
