#!/bin/bash

# Exit on any error
set -e

echo "Updating system packages..."
sudo apt update

echo "Installing Java 17..."
sudo apt install -y openjdk-17-jdk

echo "Installing Maven..."
sudo apt install -y maven

echo "Installing Git..."
sudo apt install -y git

echo "Setting JAVA_HOME..."
JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
echo "export JAVA_HOME=$JAVA_HOME" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc

echo "Java version:"
java -version

echo "Maven version:"
mvn -version

echo "Setup complete!"


REPO_URL="https://github.com/nreddywellness360/taskmaster"  # Replace with your repository URL
PROJECT_DIR="taskmaster"                             # Replace with your project directory name

echo "Cloning repository..."
git clone "$REPO_URL" "$PROJECT_DIR"
cd "$PROJECT_DIR"

echo "Building the project with Maven..."
mvn clean install

echo "Running the application..."
mvn spring-boot:run
