#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

echo -e "${BLUE}🚀 Juno Dashboard Setup${ENDCOLOR}"

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${YELLOW}Node.js not found. Installing Node.js...${ENDCOLOR}"
    
    # Install Node.js based on distribution
    if command -v dnf &> /dev/null; then
        # Fedora/RHEL/CentOS
        sudo dnf install -y nodejs npm
    elif command -v apt &> /dev/null; then
        # Ubuntu/Debian
        sudo apt update
        sudo apt install -y nodejs npm
    else
        echo -e "${RED}Unable to install Node.js automatically. Please install it manually.${ENDCOLOR}"
        exit 1
    fi
fi

echo -e "${GREEN}Node.js version: $(node --version)${ENDCOLOR}"
echo -e "${GREEN}NPM version: $(npm --version)${ENDCOLOR}"

# Navigate to dashboard directory
cd dashboard

# Check if package.json exists
if [ ! -f "package.json" ]; then
    echo -e "${RED}package.json not found in dashboard directory${ENDCOLOR}"
    exit 1
fi

# Install dependencies
echo -e "${YELLOW}Installing dashboard dependencies...${ENDCOLOR}"
npm install

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Dependencies installed successfully!${ENDCOLOR}"
    echo -e "${BLUE}Starting Juno Dashboard...${ENDCOLOR}"
    echo -e "${YELLOW}Dashboard will be available at: http://localhost:3000${ENDCOLOR}"
    echo -e "${YELLOW}Press Ctrl+C to stop the dashboard${ENDCOLOR}"
    echo ""
    
    # Start the dashboard
    npm start
else
    echo -e "${RED}Failed to install dependencies${ENDCOLOR}"
    exit 1
fi
