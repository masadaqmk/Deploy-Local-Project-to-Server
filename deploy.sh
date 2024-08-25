#!/bin/bash


npm run build

# Define variables
LOCAL_BUILD_DIR="./build/"
REMOTE_USER="" # Username
ZIP_FILE="build.zip" # Zip Folder
REMOTE_PASS="" # Server Password 
REMOTE_HOST="" # Server Host
REMOTE_DIR="/var/www/projects/react/" # Project Folder on Server

# Ensure the REMOTE_HOST variable is set correctly
if [ -z "$REMOTE_HOST" ]; then
    echo "Error: REMOTE_HOST is not set. Please provide the correct server hostname."
    exit 1
fi

# Create a zip file of the build folder
echo "Zipping the build folder..."
zip -r $ZIP_FILE $LOCAL_BUILD_DIR

# Upload the zip file using sshpass to handle password input
echo "Uploading $ZIP_FILE to $REMOTE_HOST:$REMOTE_DIR"
sshpass -p "$REMOTE_PASS" scp "$ZIP_FILE" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"

# Check if the upload was successful
if [ $? -eq 0 ]; then
    echo "$ZIP_FILE successfully uploaded to the live server."
else
    echo "File upload failed. Please check your credentials and try again."
    exit 1
fi

echo "Remove the file on the server..."
sshpass -p "$REMOTE_PASS" ssh "$REMOTE_USER@$REMOTE_HOST" "cd $REMOTE_DIR && rm -r build"

# Run the unzip command on the server to extract the files
echo "Unzipping the file on the server..."
sshpass -p "$REMOTE_PASS" ssh "$REMOTE_USER@$REMOTE_HOST" "cd $REMOTE_DIR && unzip -o $ZIP_FILE && rm $ZIP_FILE"

# Check if the unzip command was successful
if [ $? -eq 0 ]; then
    echo "Files successfully unzipped on the server."
else
    echo "Unzipping failed. Please check the server configuration and try again."
    exit 1
fi

# Optionally, clean up the local zip file after upload
echo "Cleaning up local zip file..."
rm $ZIP_FILE

echo "Done."
