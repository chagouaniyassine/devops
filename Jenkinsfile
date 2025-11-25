pipeline {
    agent any

    tools {
        // Remplacez les valeurs ci‑dessous par les labels configurés dans Jenkins
        jdk 'JAVA_HOME'
        maven 'M2_HOME'
    }

    stages {
        stage('Checkout') {
            steps {
                // checkout du repo et de la branche 'manel'
                git branch: 'manel', url: 'https://github.com/chagouaniyassine/devops.git'
            }
        }

        stage('Compile') {
            steps {
                // option -B pour build non interactif, adapter si nécessaire
                sh 'mvn -B clean compile'
            }
        }
    }
}
