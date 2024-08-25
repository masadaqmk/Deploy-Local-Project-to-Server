Project Deployment Script
This repository contains a shell script for automating the deployment of a React application to a remote server. The script builds the project, compresses the build files, uploads them to the server, and then unzips the files to the correct directory.

Prerequisites
Before you run this script, ensure you have the following installed:

npm: Used to build the project.
sshpass: Used to automate the SSH password input.
You can install sshpass using the following command:

bash
sudo apt-get install sshpass
Usage
Clone the repository to your local machine.

bash
git clone https://github.com/your-username/your-repo.git
cd your-repo
Build the React application.

The script starts by running the build command for your React app:

bash
npm run build
Configure the script.

Open the deploy.sh script in a text editor and set the following variables:

bash
LOCAL_BUILD_DIR="./build/"
REMOTE_USER="your-username" # Replace with your remote server's username
ZIP_FILE="build.zip"
REMOTE_PASS="your-password" # Replace with your remote server's password
REMOTE_HOST="your-server-ip-or-domain" # Replace with your server's hostname or IP
REMOTE_DIR="/var/www/projects/react/" # Replace with the directory on the server where files should be uploaded
Run the script.

Execute the script to deploy your project:

bash
./deploy.sh
Cleanup.

The script automatically cleans up the local build.zip file after deployment.

Troubleshooting
REMOTE_HOST not set: Ensure the REMOTE_HOST variable in the script is correctly set to your server's hostname or IP address.
Upload issues: Double-check your SSH credentials and ensure the target directory on the server is correctly set.
Unzip failure: Ensure the unzip utility is installed and configured correctly on your server.
License
This project is licensed under the MIT License - see the LICENSE file for details.
