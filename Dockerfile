# Container image that runs your code
FROM debian
# Copies your code file from your action repository to the filesystem path `/` of the container
COPY filters-build.sh /filters-build.sh
RUN apt-get update && apt-get install -y wget
RUN apt-get update && apt-get install -y python3 && apt-get install -y git python3-pip curl
RUN wget -O gh https://github.com/cli/cli/releases/download/v1.14.0/gh_1.14.0_linux_amd64.deb
RUN dpkg -i gh
# Code file to execute when the docker container starts up (`entrypoint.sh`)
RUN chmod 777 /filters-build.sh
ENTRYPOINT ["/bin/bash","/filters-build.sh"]