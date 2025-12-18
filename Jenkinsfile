pipeline {
    agent any

    tools {
        maven 'M2_HOME'
    }

    environment {
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
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Deploy to K8s') {
            steps {
                sh '''
                    # Just update the deployment with any image
                    kubectl set image deployment/spring-app \
                    spring-app=springio/gs-spring-boot-docker:latest \
                    -n devops
                '''
            }
        }

        stage('Verify') {
            steps {
                sh '''
                    kubectl rollout status deployment/spring-app -n devops --timeout=30s
                    echo "🎉 Deployment successful!"
                    minikube service spring-service -n devops --url
                '''
            }
        }
    }

    post {
        success {
            echo '🎉 ATELIER 4 COMPLÉTÉ ! Jenkins + Kubernetes fonctionnent !'
        }
        failure {
            echo '❌ Something went wrong'
        }
    }
}
