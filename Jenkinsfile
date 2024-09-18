 pipeline {
    environment {
        IMAGE_NAME = "ic-webapp"
        CONTAINER_APP_PORT = "8080"
        APP_EXPOSED_PORT = "80"
        DOCKERHUB_ID = "alexzaza"
        DOCKERHUB_PASSWORD = credentials('dockerhub_password')
        IMAGE_TAG = "1.0"  // Added to ensure it's set
    }
    agent none
    stages {
        stage('Build image') {
            agent any
            steps {
                script {
                    sh 'docker build --no-cache -f ./Dockerfile_v1.0 -t alexzaza/$IMAGE_NAME:$IMAGE_TAG .'
                }
            }
        }
        stage('Run container based on built image') {
            agent any
            steps {
                script {
                    sh '''
                        echo "Cleaning existing container if it exists"
                        docker ps -a | grep -i $IMAGE_NAME && docker rm -f ${IMAGE_NAME}
                        docker run --name $IMAGE_NAME -d -p ${APP_EXPOSED_PORT}:${CONTAINER_APP_PORT} alexzaza/$IMAGE_NAME:$IMAGE_TAG
                        sleep 5
                    '''
                }
            }
        }
         stage('Test image') {
             agent any
              steps {
                  script {
                    // Set the host IP explicitly
                      def HOST_IP = "localhost"
                      sh '''
                         curl -I http://$HOST_IP:$APP_EXPOSED_PORT
                        sleep 5
                 '''
        }
    }
}

        stage('Clean Container') {
            agent any
            steps {
                script {
                    sh '''
                        docker stop $IMAGE_NAME
                        docker rm $IMAGE_NAME
                    '''
                }
            }
        }
        stage('Login and Push Image on Docker Hub') {
            agent any
            steps {
                script {
                    sh '''
                        echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_ID --password-stdin
                        docker push ${DOCKERHUB_ID}/$IMAGE_NAME:$IMAGE_TAG
                    '''
                }
            }
        }
    }
}

