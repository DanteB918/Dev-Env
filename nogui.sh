#! /bin/bash
filename=wordpress
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "\nPick which you would like to create or stop.\n"

echo -e "Please type in the number corresponding the build.\n 1. Wordpress\n 2. Stop Wordpress site \n 3. Show all Docker Containers\n"

read choice

if [[ $choice == "1" ]];then

echo -e "\nNow Creating your wordpress website...\n"

if [[ $(ss -tulpn | grep 5080) ]];then
	echo "Port 5080 is already allocated. Attempting to decompose the wordpress site on the port."
	echo -e "\n Decomposing.."
	$(ANSIBLE_LOCALHOST_WARNING=false ansible-playbook .dewordpress.yml)
		if [[ $(ss -tulpn | grep 5080) ]];then
			echo "PORT IS STILL ALLOCATED, please close containers from something else"
			exit
		fi
	echo -e "\nSuccessfully composed down containers. now re-composing."
fi

$(ANSIBLE_LOCALHOST_WARNING=false ansible-playbook .wordpress.yml)

echo "..*"
sleep 1
echo ".**"
sleep 1
echo "***"
sleep 1

echo -e "Site created\n\n Here are your container names.\n"
echo $(docker ps | awk '{print $NF}')

echo -e "\nPlease visit ${RED}localhost:5080${NC} in order to view your site."
elif [[ $choice == "2" ]];then
  	echo -e "\n Decomposing.."
        	$(ANSIBLE_LOCALHOST_WARNING=false ansible-playbook .dewordpress.yml)
                	if [[ $(sudo ss -tulpn | grep 5080) ]];then
                        	echo "PORT IS STILL ALLOCATED"
				exit
                	fi
	echo "..*"
	sleep 1
	echo ".**"
	sleep 1
	echo "***"
	sleep 1
        echo -e "\nSuccessfully composed down containers."
elif [[ $choice == "3" ]];then
	echo -e "\nALL CONTAINERS:\n"
	docker ps
fi
