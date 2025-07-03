#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

echo -e "${BLUE}🚀 Juno Dashboard Setup${ENDCOLOR}"
echo ""

# Detect distribution
detect_distribution() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
        VERSION=$VERSION_ID
        echo -e "${GREEN}Detected system: $PRETTY_NAME${ENDCOLOR}"
    else
        echo -e "${YELLOW}Could not detect distribution, proceeding with generic approach${ENDCOLOR}"
        DISTRO="unknown"
    fi
}

# Function to check Docker permissions
check_docker_permissions() {
    if ! docker ps >/dev/null 2>&1; then
        echo -e "${YELLOW}Warning: Cannot access Docker without sudo.${ENDCOLOR}"
        echo -e "${YELLOW}This usually means your user is not in the docker group.${ENDCOLOR}"
        echo -e "${YELLOW}The dashboard will need to run with sudo privileges.${ENDCOLOR}"
        echo ""
        echo -e "${BLUE}To fix this permanently:${ENDCOLOR}"
        echo "1. Run: sudo usermod -aG docker \$USER"
        echo "2. Log out and log back in (or restart your system)"
        echo ""
        return 1
    fi
    return 0
}

# Detect the current distribution
detect_distribution
echo ""

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
    
    # Check Docker permissions
    echo -e "${BLUE}Checking Docker permissions...${ENDCOLOR}"
    if check_docker_permissions; then
        echo -e "${GREEN}Docker permissions OK!${ENDCOLOR}"
        echo -e "${BLUE}Starting Juno Dashboard...${ENDCOLOR}"
        echo -e "${YELLOW}Dashboard will be available at: http://localhost:3000${ENDCOLOR}"
        echo -e "${YELLOW}Press Ctrl+C to stop the dashboard${ENDCOLOR}"
        echo ""
        
        # Start the dashboard
        npm start
    else
        echo -e "${YELLOW}Docker permissions issue detected.${ENDCOLOR}"
        echo -e "${BLUE}Would you like to start the dashboard with sudo? (y/N)${ENDCOLOR}"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            echo -e "${BLUE}Starting Juno Dashboard with sudo...${ENDCOLOR}"
            echo -e "${YELLOW}Dashboard will be available at: http://localhost:3000${ENDCOLOR}"
            echo -e "${YELLOW}Press Ctrl+C to stop the dashboard${ENDCOLOR}"
            echo ""
            sudo npm start
        else
            echo -e "${RED}Dashboard not started. Please fix Docker permissions and try again.${ENDCOLOR}"
            exit 1
        fi
    fi
else
    echo -e "${RED}Failed to install dependencies${ENDCOLOR}"
    exit 1
fi
