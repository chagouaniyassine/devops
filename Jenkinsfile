pipeline {
    agent any

    tools {
        maven 'M2_HOME'
        jdk 'JAVA_HOME'
    }

    environment {
        DOCKER_IMAGE = 'spring-k8s-app'
        K8S_NAMESPACE = 'devops'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'manel2',
                   url: 'https://github.com/chagouaniyassine/devops.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        // ⭐ NOUVELLES ÉTAPES POUR L'ATELIER 4 ⭐
        stage('Package JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Utiliser Docker de Minikube
                    sh '''
                        eval $(minikube docker-env)
                        docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} .
                        eval $(minikube docker-env -u)
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh """
                    kubectl set image deployment/spring-app \\
                    spring-app=${DOCKER_IMAGE}:${BUILD_NUMBER} \\
                    -n ${K8S_NAMESPACE}
                """
            }
        }

        stage('Verify Deployment') {
            steps {
                sh """
                    kubectl rollout status deployment/spring-app -n ${K8S_NAMESPACE} --timeout=120s
                """
            }
        }
    }

    post {
        success {
            echo '🎉 Pipeline réussi ! Application déployée sur Kubernetes.'
            sh '''
                echo "Application accessible via:"
                minikube service spring-service -n devops --url || true
            '''
        }
        failure {
            echo '❌ Pipeline échoué.'
        }
    }
}
