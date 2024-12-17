#!/bin/bash

echo "============================"
echo "   GetGrass Bot Installer   "
echo "============================"

# Prompt for UserId
read -p "Enter your User ID: " userId

# Prompt for Proxies
echo "Enter your proxies (one per line). When finished, press Ctrl+D:"
proxies=$(cat)

# Install Node.js
echo "Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash -
sudo apt install -y nodejs

# Clone the repository
echo "Cloning the repository..."
git clone https://github.com/Pheanhutz/omsim.git
cd omsim || { echo "Failed to navigate to the repository directory"; exit 1; }

# Install dependencies
echo "Installing dependencies..."
npm install

# Configure config.js
echo "Configuring config.js..."
cat > config.js <<EOL
// configuration
const config = {
  userId: '${userId}', // Replace with Your User ID
  proxyFile: 'proxy.txt' // Path to Proxy.txt file
};
module.exports = config;
EOL

# Create proxy.txt
echo "Creating proxy.txt..."
echo "$proxies" > proxy.txt

# Start the bot
echo "Starting the bot..."
echo "Script command password: VGhpcyBmcmVlbWl1bSBzY3JpcHQgd2lsbCBiZSBwdWJsaXNoZWQgYW55b25lIGNhbiB1c2UgaXQsIGlmIHRoZXkgc3RhciBhbmQgZm9yayB0aGUgZ3Jhc3MgYm90IHJlcG9zaXRvcnksIGFuZCBzZW5kIFNTIHRvIEF1dG9yJ3MgdGVsZWdyYW0gRE0sIEJlc3QgUmVnYXJkcyBmdXJxb25mbHlubiB7Z2V0Z3Jhc3MtYm90LXByZW1pdW19"
npm start
