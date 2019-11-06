#!/bin/bash
set -e

#do an update
sudo yum update -y

### setup JENKINS
### install JDK-8 and update JRE link
sudo yum -y install java-1.8.0-openjdk-devel.x86_64

### install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
sudo yum install jenkins -y

sudo service jenkins start


## install ansible
sudo amazon-linux-extras install ansible2 -y


## install terraform
sudo curl -O https://releases.hashicorp.com/terraform/0.12.0-rc1/terraform_0.12.0-rc1_linux_amd64.zip
sudo unzip terraform_0.12.0-rc1_linux_amd64.zip -d /usr/bin/


## install git
sudo yum install git -y

## install maven
sudo yum install maven -y



## install nodejs
sudo yum install -y gcc-c++ make
sudo curl -sL https://rpm.nodesource.com/setup_10.x | sudo -E bash -
sudo yum install yarn -y
sudo yum install nodejs -y
