pipeline {
    agent any

    tools {
        maven 'M2_HOME'  // Assure-toi que c'est bien le nom de ton installation Maven dans Jenkins
    }

    stages {
        stage('GIT') {
            steps {
                git(
                    branch: 'Youssef',  // remplace par ta branche si besoin
                    url: 'https://github.com/chagouaniyassine/devops.git',
                    credentialsId: 'jenkins-example-github-pat'  // ton ID de credentials GitHub
                )
            }
        }

        stage('MVN SONARQUBE') {
            steps {
                sh """
                mvn clean install sonar:sonar \
                    -Dsonar.projectKey=devops-project \
                    -Dsonar.host.url=http://localhost:9000 \
                    -Dsonar.login=squ_ee069c649be0bff454cc4bc790a5c0fb257b3197
                """
            }
        }
    }
}