@NonCPS
def generateTag() {
    return "build-" + new Date().format("yyyyMMdd-HHmmss")
}

pipeline {
    environment {
        registry = "adi0222/surveyformimage"
        registryCredential = 'Georgemason@4'

        KUBECONFIG_CREDENTIALS_ID = '5574b1da-9b69-451a-b775-bdf66c5ec6e2'
    }
    agent any

    stages{

        stage('Build') {
            steps {
                script {
                    checkout scm
                    sh 'echo ${BUILD_TIMESTAMP}'
                    tag = generateTag()
                    docker.withRegistry('',registryCredential){
                      def customImage = docker.build("adi0222/surveyformimage:"+tag)
                   }
               }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    sh 'echo ${BUILD_TIMESTAMP}'
                    docker.withRegistry('',registryCredential) {
                        def image = docker.build('adi0222/surveyformimage:'+tag, '.')
                        docker.withRegistry('',registryCredential) {
                            image.push()
                        }
                    }
                }
            }
        }

    stage('Deploying Rancher to single node') {
        steps {
            script{
               sh 'kubectl set image deployment/surveyform container-0=adi0222/surveyformimage:'+tag
            }
        }
    }

    stage('Deploying Rancher to Load Balancer') {
       steps {
          script{
             sh 'kubectl set image deployment/surveyformlb container-0=adi0222/surveyformimage:'+tag
          }
       }
    }

	stage('Deploying Rancher to Node Port') {
       steps {
          script{
             sh 'kubectl set image deployment/surveyformnp container-0=adi0222/surveyformimage:'+tag
          }
       }
    }

    }
}
