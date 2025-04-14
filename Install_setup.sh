#!/bin/bash

# Ensure the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Exit on any command failure
set -e

# Function to check if a package is installed
is_installed() {
    local package=$1
    dpkg -l | grep -qw "$package"
}

# Function to get the version of a Debian package
get_package_version() {
    local package=$1
    dpkg -s "$package" 2>/dev/null | grep 'Version:' | awk '{print $2}'
}

# Function to check if a Snap package is installed
is_snap_installed() {
    local snap_package=$1
    snap list | grep -qw "$snap_package"
}

# Function to get the version of a Snap package
get_snap_version() {
    local snap_package=$1
    snap list | grep -w "$snap_package" | awk '{print $3}'
}

# Update and install basic tools
if ! is_installed curl; then
    sudo apt update
    sudo apt install -y curl
    echo "curl installation completed."
else
    curl_version=$(get_package_version curl)
    echo "curl is already installed."
fi

if ! is_installed git; then
    sudo apt install -y git
    git_version=$(get_package_version git)
    echo "git installation completed (version: $git_version)."
else
    git_version=$(get_package_version git)
    echo "git is already installed (version: $git_version)."
fi

# Install zsh
if ! is_installed zsh; then
    sudo apt install -y zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    chsh -s $(which zsh)
    echo "zsh installation completed."
else
    zsh_version=$(get_package_version zsh)
    echo "zsh is already installed."
fi

ZSHRC_FILE=~/.zshrc

# Set nano as the default editor in .zshrc
if ! grep -q 'export EDITOR=nano' ~/.zshrc; then
    echo 'export EDITOR=nano' >> ~/.zshrc
    echo 'export VISUAL="$EDITOR"' >> ~/.zshrc
    source ~/.zshrc
    echo "Nano has been set as the default editor for Zsh."
else
    echo "Nano is already set as the default editor in .zshrc."
fi

# Install VSCode
if ! is_installed code; then
    sudo apt-get install -y wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    rm -f packages.microsoft.gpg
    sudo apt install -y apt-transport-https
    sudo apt update
    sudo apt install -y code
    code_version=$(get_package_version code)
    echo "VSCode installation completed (version: $code_version)."
else
    code_version=$(get_package_version code)
    echo "VSCode is already installed (version: $code_version)."
fi

# Install jdk21
if ! is_installed openjdk-21-jdk; then
    sudo apt install -y openjdk-21-jdk
    echo "JDK 21 installation completed."
else
    jdk_version=$(get_package_version openjdk-21-jdk)
    echo "JDK 21 is already installed (version: $jdk_version)."
fi

# Install Maven
if ! is_installed maven; then
    sudo apt install -y maven
    maven_version=$(get_package_version maven)
    echo "maven installation completed (version: $maven_version)."
else
    maven_version=$(get_package_version maven)
    echo "maven is already installed (version: $maven_version)."
fi

# Install bat and add cat alias
if ! is_installed bat; then
    sudo apt install -y bat    
    if ! grep -q "alias cat=bat" "$ZSHRC_FILE"; then
        echo "alias cat=bat" >> "$ZSHRC_FILE"
        echo "Alias 'cat=bat' added to $ZSHRC_FILE."
    else
        echo "Alias 'cat=bat' already exists in $ZSHRC_FILE."
    fi
    source "$ZSHRC_FILE"
    echo "Alias 'cat=bat' applied."
else
    echo "bat is already installed"
fi

# Install Docker
if ! is_installed docker-ce; then
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    echo "Docker installed (version: $fd_version)."
else
    docker_version=$(get_package_version docker-ce)
    echo "Docker is already installed (version: $docker_version)."
fi

# Install fd-find and create alias
if ! is_installed fd-find; then
    sudo apt install -y fd-find
    sudo ln -s /usr/bin/fdfind /usr/bin/fd
    echo "fd-find installation completed"
else
    echo "fd-find is already installed."
fi

# Initialize zoxide for Zsh
if ! grep -q "zoxide init zsh" "$ZSHRC_FILE"; then
    echo "eval \"\$(zoxide init zsh)\"" >> "$ZSHRC_FILE"
    echo "zoxide initialized in $ZSHRC_FILE."
    source "$ZSHRC_FILE"
else
    echo "zoxide is already initialized in $ZSHRC_FILE."
fi

# Install DBeaver
if ! is_snap_installed dbeaver-ce; then
    sudo snap install -y dbeaver-ce
    dbeaver_version=$(get_snap_version dbeaver-ce)
    echo "dbeaver-ce installation completed (version: $dbeaver_version)."
else
    dbeaver_version=$(get_snap_version dbeaver-ce)
    echo "dbeaver-ce is already installed (version: $dbeaver_version)."
fi

# Main script
if ! is_installed postgresql; then
    sudo apt install -y postgresql
    echo "Setting default password for the postgres user..."
    sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'password1';"
    sudo systemctl enable postgresql
    sudo systemctl start postgresql
    if is_installed postgresql; then
        installed_version=$(get_package_version postgresql)
        echo "PostgreSQL installation completed (version: $installed_version)"
    else
        echo "PostgreSQL installation failed."
        exit 1
    fi
else
    current_version=$(get_package_version postgresql)
    echo "PostgreSQL is already installed (version: $current_version)"
fi

# Reboot the system
# echo "Rebooting the system."
# sudo reboot
