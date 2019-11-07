#!/bin/bash
set -e

#do an update
sudo yum update -y


### install JDK-8 and update JRE link
sudo yum -y install java-1.8.0-openjdk-devel.x86_64

## install tomcat
mkdir /tmp/tomcat
cd /tmp/tomcat

curl https://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.47/bin/apache-tomcat-8.5.47.tar.gz -o apache-tomcat-8.5.47.tar.gz
tar xvf apache-tomcat-8.5.47.tar.gz 
sudo chmod 777 -R apache-tomcat-8.5.47
cd apache-tomcat-8.5.47/bin/

## start tomcat
./startup.sh


## install nodejs
sudo yum install -y gcc-c++ make
sudo curl -sL https://rpm.nodesource.com/setup_10.x | sudo -E bash -
sudo yum install yarn -y
sudo yum install nodejs -y

