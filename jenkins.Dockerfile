FROM jenkins/jenkins:lts-jdk17
USER root
RUN mkdir -p /etc/docker && \
    echo '{ \
    "insecure-registries" : [ "nexus:8082" ] \
    }' > /etc/docker/daemon.json
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli net-tools lsof iputils-ping
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"
