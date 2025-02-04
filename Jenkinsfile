pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "adi0222/surveyformimage:${env.BUILD_ID}"
        KUBECONFIG_CREDENTIALS_ID = '5574b1da-9b69-451a-b775-bdf66c5ec6e2'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("$DOCKER_IMAGE")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'DockerHubCredentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                        sh "docker push $DOCKER_IMAGE"
                    }
                }
            }
        }

        stage('Deploying to Rancher as Load Balancer') {
            steps {
                withCredentials([file(credentialsId: "$KUBECONFIG_CREDENTIALS_ID", variable: 'KUBECONFIG')]) {
                    sh 'kubectl set image deployment/surveyformlb container-0=$DOCKER_IMAGE'
                }
            }
        }

        stage('Deploying to Rancher as Node Port') {
            steps {
                withCredentials([file(credentialsId: "$KUBECONFIG_CREDENTIALS_ID", variable: 'KUBECONFIG')]) {
                    sh 'kubectl set image deployment/surveyformnp container-0=$DOCKER_IMAGE'
                }
            }
        }
    }
}
