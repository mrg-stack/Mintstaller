# Mintstaller Setup Script

This project provides a one-shot setup script for Linux Mint systems.

The script:
- updates and upgrades the system
- installs base utilities and development tools
- adds third-party APT repositories (Brave, Visual Studio Code, Signal)
- installs desktop applications (Firefox, Brave, Thunderbird, VLC, LibreOffice, Signal, VS Code)
- removes unwanted packages (Hexchat)
- cleans unused dependencies and package cache

## Prerequisites

- Linux Mint (or Ubuntu-based distro with `apt`)
- a user account with `sudo` privileges
- internet connection

## File

- `mint-setup.sh`: main installer script

## How To Run

From the project directory:

```bash
chmod +x mint-setup.sh
./mint-setup.sh
```

Or run without changing permissions:

```bash
bash mint-setup.sh
```

## Notes

- The script uses `set -e`, so it stops on the first error.
- You may be prompted for your sudo password.
- Review the script before running it on a production machine.
