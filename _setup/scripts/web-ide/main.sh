#!/usr/bin/env bash
set -e
set -x

# Create a file if the scripts fails.
function error {
  touch /tmp/failed.txt
}
# Call error function if scripts fails
trap error ERR

INSTALL_DIR="/home/ec2-user/theia"
WORKSPACE_DIR="/home/ec2-user/playground"
PORT="8080"

## Install Theia Start ##

# Install dependencies
sudo yum install gcc-c++ git -y

# Install node version 10.11.0
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.5/install.sh | bash
. ~/.bash_profile
nvm install 10.11.0

# Install yarn
npm install -g yarn

# Setup Theia install directory
mkdir -p "$INSTALL_DIR"

# Setup workspace directory
mkdir -p "$WORKSPACE_DIR"

# Copy Theia dependency file to the install directory
cp /tmp/web-ide/config/package.json "$INSTALL_DIR"
cd "$INSTALL_DIR"

# Install dependencies
yarn

# Build the application 
yarn theia build

# Start Theia
#nohup yarn theia start $WORKSPACE_DIR --hostname 0.0.0.0 --port $PORT &

# Using sreen to keep process running if deployed via terraform.
screen -d -m yarn theia start $WORKSPACE_DIR --hostname 0.0.0.0 --port $PORT
sleep 1

echo "[ INFO ]: Theia installation complete"

## Install Theia End ##

## Install Terraform start ##   

wget https://releases.hashicorp.com/terraform/0.12.16/terraform_0.12.16_linux_amd64.zip

unzip terraform_0.12.16_linux_amd64.zip

sudo mv terraform /usr/local/bin/


## Install Terraform End ##

## Install Ansible Start ##

cd /tmp
wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -ivh epel-release-latest-7.noarch.rpm
sudo yum install ansible -y

## Install Ansible End ##