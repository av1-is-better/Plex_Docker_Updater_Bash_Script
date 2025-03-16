# Plex Docker Updater Bash Script  

This repository contains a Bash script and Docker Compose configuration to manage and update a Plex Media Server running in a Docker container. The script automates the process of checking for updates, stopping the existing container, pulling the latest image, and restarting Plex while preserving configurations and media libraries.  

## Features  
✅ **Automated Updates** – Checks for the latest Plex image and updates it automatically.  
✅ **Safe Restart** – Gracefully stops and removes the old container before deploying a new one.  
✅ **Persistent Data** – Ensures all Plex settings, metadata, and media libraries remain intact.  
✅ **Pre-update Checks** – Validates internet connection, Docker installation, and necessary files before proceeding.  
✅ **Interactive Confirmation** – Provides prompts for user confirmation before critical steps.  
✅ **Logging & Error Handling** – Displays progress messages and catches potential failures.  

## Prerequisites  
Before using this script, ensure you have the following installed:  
- Docker: [Install Docker](https://docs.docker.com/engine/install/)  
- Docker Compose: [Install Docker Compose](https://docs.docker.com/compose/install/)  

## Installation & Setup  

1. Clone this repository:  
   ```bash
   git clone https://github.com/av1-is-better/Plex_Docker_Updater_Bash_Script.git
   cd Plex_Docker_Updater_Bash_Script
   ```

2. Modify the `docker-compose.yml` file if needed (e.g., update volumes, environment variables, etc.).  

3. Ensure the script has execution permissions:  
   ```bash
   chmod +x update.sh
   ```

4. Run the update script:  
   ```bash
   ./update.sh
   ```

## Configuration  

### `update.sh`  
This Bash script performs the following steps:  
1. Checks for an active internet connection.  
2. Verifies that the required directory and `docker-compose.yml` file exist.  
3. Ensures Docker is installed and running.  
4. Stops and removes the existing Plex container if present.  
5. Removes the old Docker image.  
6. Pulls and runs the latest Plex image using `docker-compose up -d`.  

### `docker-compose.yml`  
Defines the Plex Docker container configuration:  
- Uses the latest **linuxserver/plex** image.  
- Runs with **host networking** for best performance.  
- Maps volumes for **configuration** and **media files**.  
- Uses specific **PUID, PGID, and timezone** settings.  

## Troubleshooting  

- **Permission Denied**: Run `chmod +x update.sh` and retry.  
- **Docker Not Found**: Ensure Docker is installed and accessible from your shell.  
- **No Internet Connection**: Check network settings before running the script.  


---

Let me know if you want any modifications! 🚀