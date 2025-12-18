pipeline {
    agent any

    tools {
        maven 'M2_HOME'
    }

    environment {
        K8S_NAMESPACE = 'devops'
        DOCKER_IMAGE = 'manelhomri2/monimage-java:1.0'
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
                    echo "🚀 Deploying ${DOCKER_IMAGE} to Kubernetes..."
                    kubectl config use-context minikube
                    kubectl set image deployment/spring-app \
                    spring-app=${DOCKER_IMAGE} \
                    -n ${K8S_NAMESPACE}
                '''
            }
        }

        stage('Verify') {
            steps {
                sh '''
                    echo "🔍 Verifying deployment of ${DOCKER_IMAGE}..."
                    kubectl rollout status deployment/spring-app -n ${K8S_NAMESPACE} --timeout=120s
                    echo "✅ Deployment successful!"
                    
                    echo "📊 Deployment status:"
                    kubectl get deployments -n ${K8S_NAMESPACE} -o wide
                    
                    echo "🐳 Pods status:"
                    kubectl get pods -n ${K8S_NAMESPACE} -o wide
                    
                    # Attendre que le pod soit prêt
                    sleep 15
                    
                    # Afficher les logs
                    POD_NAME=$(kubectl get pods -n ${K8S_NAMESPACE} -l app=spring-app -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || echo "")
                    if [ ! -z "$POD_NAME" ]; then
                        echo "📋 Logs from pod $POD_NAME:"
                        kubectl logs -n ${K8S_NAMESPACE} $POD_NAME --tail=30 || echo "⚠️ Cannot get logs yet"
                    else
                        echo "⚠️ No pod found with label app=spring-app"
                    fi
                    
                    echo "🎉 VOTRE IMAGE ${DOCKER_IMAGE} EST DÉPLOYÉE AVEC SUCCÈS !"
                '''
            }
        }
    }

    post {
        success {
            echo '🎉 ATELIER 4 COMPLÉTÉ ! Jenkins + Kubernetes fonctionnent !'
            echo '✅ Votre propre image Docker est déployée sur K8s !'
            echo '📦 Image: manelhomri2/monimage-java:1.0'
        }
        failure {
            echo '❌ Something went wrong'
            echo '🔧 Check: 1) Minikube running 2) kubectl config 3) Docker Hub access'
        }
    }
}
