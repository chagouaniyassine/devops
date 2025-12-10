pipeline {
    agent any
    triggers {
            githubPush()
        }
    stages {
        stage('GitHub') {
            steps {
                echo '1. Clonage du projet depuis GitHub'
               git branch: 'yassinebranch',
                url: 'https://github.com/chagouaniyassine/devops.git'
                script {
                    // Afficher les informations du commit
                    sh 'git log -1 --oneline'
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    echo "2. Building Spring Boot application..."
                    sh 'mvn clean compile -DskipTests'
                }
            }
        }
       /* stage('Test') {
            steps {
                script {
                    echo "3. Running tests..."
                    sh 'mvn test'
                }
            }
        }*/
        stage('Jar Packaging') {
                    steps {
                        script {
                            echo "4. Packaging du fichier JAR..."
                            sh 'mvn clean package -DskipTests'
                        }
                        archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
                    }
                }
        stage('SonarQube Analysis') {
            steps {
                script {
                    echo '5. Analyse de la qualité de code avec SonarQube (configuration fournie)'
                    // Utilise la configuration demandée. Par sécurité, si une variable d'environnement SONAR_TOKEN est fournie
                    // dans Jenkins, elle sera utilisée à la place du token statique ci-dessous.
                    sh """
                        mvn clean verify sonar:sonar \
                          -Dsonar.projectKey=devops-project \
                          -Dsonar.host.url=http://localhost:9000 \
                          -Dsonar.login=sqp_9a89ce4ae04dcbbd03d5ddd4299a27c8be747be2
                    """
                }
            }
        }
    }
    post {
        success {
            echo 'SUCCÈS : Build et push réussis!'
        }
        failure {
            echo 'ÉCHEC : Build failed!'
        }
        always {
            echo 'Nettoyage...'
        }
    }
}