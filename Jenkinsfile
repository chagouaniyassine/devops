pipeline {
    agent any

    tools {
        maven 'M2_HOME'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'Youssef',
                    url: 'https://github.com/chagouaniyassine/devops.git'
            }
        }

        stage('Build & Test') {
            steps {
                sh 'mvn clean test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                sh '''
                mvn sonar:sonar \
                  -Dsonar.projectKey=devops-project \
                  -Dsonar.host.url=http://localhost:9000 \
                  -Dsonar.login=squ_ee069c649be0bff454cc4bc790a5c0fb257b3197
                '''
            }
        }
    }
}