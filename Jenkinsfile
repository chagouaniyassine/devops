pipeline {
    agent any
    tools {
        maven 'M2_HOME'
    }
    stages {
        stage('GIT') {
            steps {
                git(
                    branch: 'Youssef',
                    url: 'https://github.com/chagouaniyassine/devops.git',
                    credentialsId: 'jenkins-example-github-pat'
                )
            }
        }

        stage('MVN SONARQUBE') {
            steps {
                // Remplace <TOKEN> par ton token SonarQube et mon-projet par la clé de ton projet
                sh 'mvn clean install sonar:sonar -Dsonar.projectKey=mon-projet -Dsonar.host.url=http://localhost:9000 -Dsonar.login=<TOKEN>'
            }
        }
    }
}