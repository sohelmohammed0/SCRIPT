#!/bin/bash

# Exit on any error
set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" &>/dev/null
}

# Updating system packages
echo -e "\e[34mUpdating system packages...\e[0m"
sudo apt update -y && sudo apt upgrade -y

# Installing Java 17
if command_exists java; then
    echo -e "\e[32mJava is already installed:\e[0m $(java -version 2>&1 | head -n 1)"
else
    echo -e "\e[34mInstalling Java 17...\e[0m"
    sudo apt install -y openjdk-17-jdk
    echo -e "\e[32mJava installed successfully!\e[0m"
fi

# Installing Maven
if command_exists mvn; then
    echo -e "\e[32mMaven is already installed:\e[0m $(mvn -version | head -n 1)"
else
    echo -e "\e[34mInstalling Maven...\e[0m"
    sudo apt install -y maven
    echo -e "\e[32mMaven installed successfully!\e[0m"
fi

# Installing Git
if command_exists git; then
    echo -e "\e[32mGit is already installed:\e[0m $(git --version)"
else
    echo -e "\e[34mInstalling Git...\e[0m"
    sudo apt install -y git
    echo -e "\e[32mGit installed successfully!\e[0m"
fi

# Installing Docker
if command_exists docker; then
    echo -e "\e[32mDocker is already installed:\e[0m $(docker --version)"
else
    echo -e "\e[34mInstalling Docker...\e[0m"
    sudo apt install -y docker.io
    sudo systemctl enable docker
    sudo systemctl start docker
    echo -e "\e[32mDocker installed successfully!\e[0m"
    
    # Adding user to Docker group
    echo -e "\e[34mAdding ubuntu user to Docker group...\e[0m"
    sudo usermod -aG docker ubuntu
    echo -e "\e[32mUser added to Docker group!\e[0m"
    
    # Restarting system to apply changes
    echo -e "\e[34mRestarting system to apply changes...\e[0m"
    sudo reboot
fi

# Setting JAVA_HOME
JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
echo "export JAVA_HOME=$JAVA_HOME" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc

# Display installed versions
echo -e "\e[36mJava version:\e[0m"
java -version

echo -e "\e[36mMaven version:\e[0m"
mvn -version

echo -e "\e[36mDocker version:\e[0m"
docker --version
