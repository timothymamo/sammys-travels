#!/bin/bash

# Update existing packages:
sudo apt -y update
# Install prerequisite packages which let apt use packages over HTTPS:
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common
# Add the GPG key for the official Docker repository to the system:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Add the Docker repository to APT sources:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
# Install Docker:
sudo apt -y update
sudo apt -y install docker-ce

# Install Docker Compose
# Get the docker compose latest version number:
COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oE "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | sort --version-sort | tail -n 1`
# Download docker compose and save the executable file at ~/.docker/docker-cli-plugins/:
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v${COMPOSE_VERSION}/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
# Set correct permissions so that the docker-compose command is executable:
chmod +x ~/.docker/cli-plugins/docker-compose
# Test your installation:
docker compose version

# Install incron
sudo apt -y install incron
echo "root" >> /etc/incron.allow
# Start incron
systemctl start incron.service

echo '/root/passwords.txt     IN_ALL_EVENTS       /root/sammys_travels/shutdown.sh' > /root/incron.txt
incrontab -u root /root/incron.txt

rm -rf /root/incron.txt
touch ${HOME}/passwords.txt