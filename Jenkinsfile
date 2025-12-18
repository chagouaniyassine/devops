pipeline {
    agent any

    tools {
        maven 'M2_HOME'
    }

    environment {
        K8S_NAMESPACE = 'devops'
        SONAR_HOST_URL = 'http://localhost:9000'
        SONAR_TOKEN = credentials('sonar-token')
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

        stage('SonarQube Analysis') {
            steps {
                sh """
                    mvn sonar:sonar \
                    -Dsonar.projectKey=student-management \
                    -Dsonar.host.url=${SONAR_HOST_URL} \
                    -Dsonar.login=${SONAR_TOKEN}
                """
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }

        stage('Deploy to K8s') {
            steps {
                sh '''
                    echo "🚀 Applying Kubernetes manifests..."
                    
                    # Applique les fichiers YAML de déploiement
                    kubectl apply -f k8s/deployment.yaml -n ${K8S_NAMESPACE}
                    kubectl apply -f k8s/service.yaml -n ${K8S_NAMESPACE}
                    kubectl apply -f k8s/configmap.yaml -n ${K8S_NAMESPACE}
                    
                    # OU si tu as juste un fichier
                    kubectl apply -f kubernetes/ -n ${K8S_NAMESPACE}
                '''
            }
        }

        stage('Verify') {
            steps {
                sh '''
                    echo "🔍 Waiting for deployment..."
                    kubectl rollout status deployment/spring-app -n ${K8S_NAMESPACE} --timeout=180s
                    
                    echo "✅ Deployment successful!"
                    echo "📊 Services:"
                    kubectl get services -n ${K8S_NAMESPACE}
                    
                    echo "🌐 Getting application URL..."
                    minikube service spring-service -n ${K8S_NAMESPACE} --url
                '''
            }
        }
    }

    post {
        success {
            echo '🎉 PIPELINE COMPLET : SonarQube + Tests + K8s Déploiement !'
        }
        failure {
            echo '❌ Pipeline failed'
        }
    }
}
