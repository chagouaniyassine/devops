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
                    
                    # Vérification simple sans Minikube
                    echo "📊 Checking deployment status:"
                    kubectl get deployments -n devops
                    kubectl get pods -n devops
                    
                    echo "🔍 Pod details:"
                    kubectl describe pods -n devops -l app=spring-app || true
                    
                    # Optionnel: Tester l'application (décommentez si vous voulez)
                    # echo "🚀 Testing application..."
                    # kubectl port-forward deployment/spring-app 8080:8080 -n devops --address=0.0.0.0 &
                    # sleep 5
                    # curl -s http://localhost:8080/actuator/health && echo "✅ Health check passed" || echo "⚠️ Health check failed"
                    # pkill -f "port-forward" || true
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
