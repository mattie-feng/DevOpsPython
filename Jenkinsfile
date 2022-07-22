pipeline {
  agent any

  environment {
      DOCKER_CREDENTIAL_ID = 'devops-docker'
      GITHUB_CREDENTIAL_ID = 'github-token'
      KUBECONFIG_CREDENTIAL_ID = 'devops-kubeconfig'
      REGISTRY = 'docker.io'
      DOCKERHUB_NAMESPACE = 'mattie1'
      GITHUB_ACCOUNT = 'mattie-feng'
      GITHUB_APP_NAME = 'DevOpsPython'
      APP_NAME = 'devops-python'
      TAG_NAME = 'v0.1.6'
  }

  stages {
    stage ('build') {
      steps {
        container ('base') {
          sh 'docker build -f Dockerfile -t $REGISTRY/$DOCKERHUB_NAMESPACE/$APP_NAME:$TAG_NAME .'
          withCredentials([usernamePassword(passwordVariable : 'DOCKER_PASSWORD' ,usernameVariable : 'DOCKER_USERNAME' ,credentialsId : "$DOCKER_CREDENTIAL_ID" ,)]) {
            sh 'echo "$DOCKER_PASSWORD" | docker login $REGISTRY -u "$DOCKER_USERNAME" --password-stdin'
            // sh 'docker push  $REGISTRY/$DOCKERHUB_NAMESPACE/$APP_NAME:$TAG_NAME'
          }
        }
      }
    }
    stage('push with tag') {
      steps {
        container ('base') {
          input(id: 'release-image-with-tag', message: 'release image with tag?')
          withCredentials([usernamePassword(credentialsId: "$GITHUB_CREDENTIAL_ID", passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
            sh 'git config --global user.email "mattie.feng@feixitek.com" '
            sh 'git config --global user.name "$GITHUB_ACCOUNT" '
            sh 'git tag -a $TAG_NAME -m "$TAG_NAME" '
            sh 'git push http://$GIT_USERNAME:$GIT_PASSWORD@github.com/$GITHUB_ACCOUNT/$GITHUB_APP_NAME.git --tags --ipv4'
          }
          // sh 'docker tag  $REGISTRY/$DOCKERHUB_NAMESPACE/$APP_NAME:$TAG_NAME $REGISTRY/$DOCKERHUB_NAMESPACE/$APP_NAME:$TAG_NAME '
          sh 'docker push  $REGISTRY/$DOCKERHUB_NAMESPACE/$APP_NAME:$TAG_NAME '
        }
      }
    }
  }
}
