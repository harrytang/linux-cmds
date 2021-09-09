#!/bin/sh
sudo dnf install dnf-automatic -y
sudo sed -i "s/apply_updates = no/apply_updates = yes/g" /etc/dnf/automatic.conf
sudo systemctl enable --now dnf-automatic.timer
sudo yum update -y
sudo dnf install -y dnf-utils zip unzip
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce --nobest
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker $USER
