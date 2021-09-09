#!/bin/sh
sudo apt update && sudo apt upgrade -y
sudo sed -i "s/\/\/Unattended-Upgrade::Automatic-Reboot \"false\";/Unattended-Upgrade::Automatic-Reboot \"true\";/g" /etc/apt/apt.conf.d/50unattended-upgrades
sudo snap install microk8s --classic --channel=1.22/stable
sudo usermod -a -G microk8s ubuntu
sudo chown -f -R ubuntu ~/.kube
