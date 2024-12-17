pipeline {
    agent any  // Use any available Jenkins agent

    stages {

 stage('Clean Workspace') {
    steps {
        echo 'Cleaning workspace...'
        deleteDir() // Deletes all files in the workspace
    }
}
        
        stage('Checkout SCM') {
            steps {
                // Checkout the code from the repository
                checkout scm
            }
        }

        stage('Clear Cache') {
            steps {
                script {
                    sh 'npm cache clean --force'
                }
            }
        }


        stage('Install Dependencies') {
            steps {
                script {
                    echo 'Installing npm dependencies'
                    sh 'npm install'
                }
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Running tests...'
                // Uncomment if you want to run tests
                // sh 'npm test'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image'
                sh 'docker build --no-cache -t notes-app-ui:1.0 .'
            }
        }

        stage('List Docker Images') {
            steps {
                echo 'Listing Docker images'
                sh 'docker images'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: '7305bc5f-b39e-4626-9e92-455d97856104', 
                                                      usernameVariable: 'DOCKERHUB_USER_NAME', 
                                                      passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh 'docker login -u $DOCKERHUB_USER_NAME -p $DOCKERHUB_PASSWORD'
                    }
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                echo 'Tagging Docker image'
                sh 'docker tag notes-app-ui:1.0 mkprofile98/notes-app-ui:latest'
            }
        }

        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker image to Docker Hub'
                sh 'docker push mkprofile98/notes-app-ui:latest'
            }
        }

        stage('Logout from Docker Hub') {
            steps {
                echo 'Logging out from Docker Hub'
                sh 'docker logout'
            }
        }

        stage('Remove Docker Image') {
            steps {
                echo 'Removing Docker images'
                sh 'docker rmi mkprofile98/notes-app-ui:latest'
                sh 'docker rmi notes-app-ui:1.0'
            }
        }

        stage('List Docker Images After Removal') {
            steps {
                echo 'Listing Docker images after removal'
                sh 'docker images'
            }
        }
    }
}
