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
    }
}
