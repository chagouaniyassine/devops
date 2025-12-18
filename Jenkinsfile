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
                // Utilisation de Maven pour lancer SonarQube
                withMaven(maven: 'M2_HOME') {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=mon-projet -Dsonar.host.url=http://localhost:9000 -Dsonar.login=<TOKEN>'
                }
            }
        }
    }
}