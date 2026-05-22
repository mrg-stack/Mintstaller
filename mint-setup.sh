#!/bin/bash

set -e

# Adds a signed APT repository using a dedicated keyring file.
add_apt_repository() {
    local name="$1"
    local key_url="$2"
    local keyring_path="$3"
    local repo_entry="$4"
    local list_path="$5"

    echo "$name"
    sudo curl -fsSL "$key_url" | sudo gpg --dearmor -o "$keyring_path"
    echo "$repo_entry" | sudo tee "$list_path" > /dev/null
}

# Bring the base system up to date before installing new packages.
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Install the core utilities required by the rest of the setup.
echo "Installing essential packages..."
sudo apt install -y \
    build-essential \
    git \
    curl \
    wget \
    vim \
    htop \
    net-tools \
    unzip \
    ca-certificates \
    gnupg \
    software-properties-common

# Prepare the shared keyring directory used by third-party repositories.
sudo mkdir -p /etc/apt/keyrings

# Register external repositories for software not shipped in the default Mint sources.
add_apt_repository \
    "Adding Brave browser repository..." \
    "https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg" \
    "/etc/apt/keyrings/brave-browser-archive-keyring.gpg" \
    "deb [signed-by=/etc/apt/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
    "/etc/apt/sources.list.d/brave-browser-release.list"

add_apt_repository \
    "Adding Visual Studio Code repository..." \
    "https://packages.microsoft.com/keys/microsoft.asc" \
    "/etc/apt/keyrings/packages.microsoft.gpg" \
    "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
    "/etc/apt/sources.list.d/vscode.list"

add_apt_repository \
    "Adding Signal repository..." \
    "https://updates.signal.org/desktop/apt/keys.asc" \
    "/etc/apt/keyrings/signal-desktop-keyring.gpg" \
    "deb [arch=amd64 signed-by=/etc/apt/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main" \
    "/etc/apt/sources.list.d/signal-xenial.list"

# Refresh package metadata so newly added repositories are available for installation.
echo "Refreshing package lists..."
sudo apt update

# Install end-user browsing, media, and communication applications.
echo "Installing browsers and media..."
sudo apt install -y \
    firefox \
    brave-browser \
    thunderbird \
    vlc

# Install desktop productivity applications.
echo "Installing productivity tools..."
sudo apt install -y \
    libreoffice \
    signal-desktop

# Install the developer toolchain and editor.
echo "Installing development tools..."
sudo apt install -y \
    python3 \
    python3-pip \
    nodejs \
    npm \
    code

# Remove preinstalled applications that are not wanted on this system.
echo "Removing unwanted packages..."
sudo apt remove -y hexchat

# Clear unused dependencies and cached package data.
echo "Cleaning up..."
sudo apt autoremove -y
sudo apt clean

echo "Setup complete!"