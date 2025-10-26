FROM jenkins/jenkins:lts
USER root
RUN apt update && apt install -y nodejs npm && npm install -g newman
USER jenkins
