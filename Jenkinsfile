pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-app:latest' // Your Docker image name
        DOCKER_REGISTRY_URL = 'http://localhost:8082'
        NEXUS_CREDENTIALS_ID = 'nexus_creds'
        DOCKERFILE_PATH = 'webapp.Dockerfile' // Path to your Dockerfile
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout your source code
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image specifying the Dockerfile
                    docker.build(DOCKER_IMAGE, "-f ${DOCKERFILE_PATH} .")
                }
            }
        }

        stage('Push Docker Image to Nexus') {
            steps {
                script {
                    // Log in to the Nexus Docker registry
                    docker.withRegistry(DOCKER_REGISTRY_URL, NEXUS_CREDENTIALS_ID) {
                        // Push the Docker image
                        docker.image(DOCKER_IMAGE).push()
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up any Docker resources
            script {
                docker.image(DOCKER_IMAGE).remove()
            }
        }
    }
}
