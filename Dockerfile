FROM jenkins/jenkins:lts-jdk11
USER root
RUN apt-get -y update && \
	apt-get -y install build-essential wget sudo apt-utils &&  wget -qO- https://get.docker.com/ | sh &&  usermod -aG docker jenkins &&  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && apt-get update -y && apt-get install google-cloud-cli -y
USER jenkins

