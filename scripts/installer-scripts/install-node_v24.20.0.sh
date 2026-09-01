#!/bin/bash

url_node="https://nodejs.org/dist/v24.20.0/node-v24.20.0-linux-x64.tar.xz"
node_bin_path="usr/local/lib/nodejs"

# Verifying node dir
echo "Creating node file..."
if [ -d $node_bin_path ]; then
		echo "A /usr/local/lib/nodejs dir was found"
		echo "It is assume that Nodejs its already install..."
		echo "Stoping process"
		exit 1
else
    if sudo mkdir -p "/usr/local/lib/nodejs"; then
        echo "NodeJS directory created successfully."
    else
        echo "ERROR: Failed to create NodeJS directory."
        exit 1
    fi
fi

echo "Downloading NodeJS v24.20.0"
if wget "$url_node"; then
    echo "node-24.20.0 download was succesfull"
else
    echo "node-24.20.0 download stop since an error accour"
    return 1
fi

tar_file="${url_node##*/}"

if tar -xf "$tar_file"; then
    echo "$tar_file was correctly extracted"
else
    echo "$tar_file had an issues while extracting"
    exit 1
fi


echo "Moving node-v24.20.0-linux-x64 file to $node_bin_path..."
if sudo mv "./node-v24.20.0-linux-x64" "/usr/local/lib/nodejs/"; then
    echo "NodeJS dir was move succesfully"
else
    echo "ERROR: Failed to move NodeJS directory."
fi

echo "Adding Path for Node..."
# Nodejs
echo "VERSION=24.20.0" >> "$HOME/.zshrc"
echo "DISTRO=linux-x64" >> "$HOME/.zshrc"
echo 
echo "export PATH=/usr/local/lib/nodejs/node-\$VERSION-\$DISTRO/bin:\$PATH" >> "$HOME/.zshrc"
