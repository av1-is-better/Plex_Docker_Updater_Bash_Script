#!/bin/bash

DOCKER_IMAGE_NAME="lscr.io/linuxserver/plex"
CONTAINER_NAME="plex"
WORKING_DIR="/home/ubuntu/docker-containers/plex"

# colors
COLOR_WHITE="\e[97m"
COLOR_LIGHT_BLUE="\e[36m"
COLOR_LIGHT_RED="\e[91m"
COLOR_LIGHT_GREEN="\e[92m"
COLOR_YELLOW="\e[33m"
COLOR_LIGHT_PURPLE="\e[95m"

echo -e "${COLOR_YELLOW}================================"
echo -e "${COLOR_LIGHT_PURPLE}      PLEX DOCKER UPDATER       "
echo -e "${COLOR_YELLOW}================================\n"


# Checking Internet Working or not
echo -e "${COLOR_LIGHT_BLUE}1. Checking Internet Connection..."
if ping 8.8.8.8 -c 1 > /dev/null 2>&1;
then
	echo -e "\e[92m✔ Success\e[0m\n"
else
	echo -e "\e[91m✖ Failed\e[0m\n"
	echo -e "${COLOR_WHITE}Please check your internet connection."
	exit 1
fi


# Checking Container Directory Exist or not
if [[ ! -d "${WORKING_DIR}" ]];
then
	echo -e "${COLOR_LIGHT_BLUE}[EXITING]${COLOR_LIGHT_RED} ✖ Working Dir Not Found ${WORKING_DIR}"
	exit 1
fi

cd "${WORKING_DIR}"

# Function For Checking Status Code
check_status() {
    if [ $? -eq 0 ]; then
        echo -e "\e[92m✔ Success\e[0m\n"
    else
        echo -e "\e[91m✖ Failed\e[0m\n"
    fi
}

# Function For Confirmation to execute this program
confirm_continue() {
    read -rp "Press 'y' to continue: " input
    if [[ "$input" != "y" && "$input" != "Y" ]]; then
        echo -e "${COLOR_LIGHT_GREEN}Exiting..."
        exit 1
    fi
}

# Checking Docker Installation
echo -e "${COLOR_LIGHT_BLUE}2. Checking Docker Installation..."
if which docker > /dev/null 2>&1;
then
	if [ $? -eq 0 ]; then
        	echo -e "\e[92m✔ Success\e[0m\n"
    	else
        	echo -e "\e[91m✖ Failed\e[0m\n"
		echo -e "Please Install Docker https://docs.docker.com/engine/install/ubuntu/"
		exit 1
    	fi
fi



# Checking docker-compose.yml file present or not
echo -e "${COLOR_LIGHT_BLUE}3. Checking Docker-Compose File..."
if [[ ! -f ./docker-compose.yml ]]; then
	echo -e "\e[91m✖ Failed\e[0m\n"
	echo -e "docker-compose.yml file not present in container directory."
	exit 1
else
	echo -e "\e[92m✔ Success\e[0m\n"
fi



# Stopping and Removing Plex Docker Container
echo -e "${COLOR_LIGHT_BLUE}4. Checking Current Container..."
if sudo docker ps -a | grep "${CONTAINER_NAME}" > /dev/null 2>&1;
then
	plexstatus=$(sudo docker ps -a | grep "${CONTAINER_NAME}")
	if echo $plexstatus | grep "Up" > /dev/null 2>&1;
	then
		echo -e "${COLOR_LIGHT_PURPLE}[STOPPING]${COLOR_YELLOW} Plex Container"
		# Stopping Plex Container
		sudo docker stop "${CONTAINER_NAME}" > /dev/null 2>&1
		check_status
	fi
	echo -e "${COLOR_LIGHT_PURPLE}[DELETING]${COLOR_YELLOW} Plex Container${COLOR_WHITE}"
        # Removing Plex Container
	confirm_continue
        sudo docker rm "${CONTAINER_NAME}" > /dev/null 2>&1
	check_status
else
        echo -e "${COLOR_LIGHT_PURPLE}[NOT FOUND]${COLOR_LIGHT_RED} Container Not Present in Your System. \n"
fi




# Removing Plex Docker Image
echo -e "${COLOR_LIGHT_BLUE}5. Checking Docker Image..."
if sudo docker images | grep "${DOCKER_IMAGE_NAME}" > /dev/null 2>&1;
then
	echo -e "${COLOR_LIGHT_PURPLE}[DELETING]${COLOR_YELLOW} Plex Image"
        sudo docker rmi "${DOCKER_IMAGE_NAME}" > /dev/null 2>&1
	check_status
else
	echo -e "${COLOR_LIGHT_PURPLE}[NOT FOUND]${COLOR_LIGHT_RED} Plex Image Not Found \n"
fi





# Creating New Plex Docker Container
echo -e "${COLOR_LIGHT_BLUE}6. Creating New Docker Container..."
sudo docker compose up -d > /dev/null 2>&1
check_status


# Exiting
if [ $? -eq 0 ]; then
        echo -e "${COLOR_LIGHT_GREEN}================================="
	echo -e "${COLOR_LIGHT_GREEN}        PROCESS COMPLETED       "
	echo -e "${COLOR_LIGHT_GREEN}=================================\n"
fi
