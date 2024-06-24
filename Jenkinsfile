pipeline {
    agent any
    stages {
        stage('Building image') {
            steps {
                sh '''
          docker build -t webapp -t krappramiro/webapp:latest -f webapp.Dockerfile .
          '''
            }
        }
        stage('Docker Login') {
            steps {
                echo 'Docker Registry Login'
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker_creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                        sh ' echo $PASS | docker login -u $USER --password-stdin'
                    }
                }
            }
        }
        stage('Docker Push') {
            steps {
                echo 'Pushing Image to docker hub'
                sh 'docker push krappramiro/webapp:latest'
            }
        }
    }
}
