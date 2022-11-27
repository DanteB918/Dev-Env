#! /bin/bash


click_one(){ #Start/Restart WP
RED='\033[0;31m'
NC='\033[0m' # No Color

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
	$(rm log.txt)
fi

$(ANSIBLE_LOCALHOST_WARNING=false ansible-playbook .wordpress.yml | yad --title="Composing up..." --progress --pu
lsate --timeout=10)


echo -e "Site created\n\n Here are your container names.\n"
echo $(docker ps | awk '{print $NF}')

echo -e "\nPlease visit ${RED}http:localhost:5080${NC} in order to view your site."
exit
}

click_two(){ #Stop WP
   	echo -e "\n Decomposing.."
        
                	if [[ $(ss -tulpn | grep 5080) ]];then
                  	$(ANSIBLE_LOCALHOST_WARNING=false ansible-playbook .dewordpress.yml | yad --title="Decomposing" --progress --pu
lsate --timeout=10)
                     
                     
                        echo -e "\nSuccessfully composed down containers."
                       $(rm log.txt)
                     else
                     $(yad --title="Decomposing" --text="No containers to decompose on port 5080")
                        echo "No containers to decompose on port 5080"

                	fi
                  
   exit 0
}
click_three(){
   contz=$(docker ps)
   yad --text="$contz" --title="CONTAINERS"

}
click_four(){
   logs=$(docker logs  wordpress-wordpress-1 &> log.txt)
   log=$(cat log.txt)
   yad --title="CONTAINER LOGS:" --button="GET LOGS":"$logs" --text="$log"
}

export -f click_one click_two click_three click_four



yad --text-align=center --center --title="Local Wordpress Setup" --text="\nLocal environment set-up. Choose your option.\n For more info, see the terminal.\n" \
--button="Start/Restart!wordpress-icon.png":"bash -c click_one" --button="Stop!wordpress-icon.png":"bash -c click_two" --button="Show all Containers!docker.png":"bash -c click_three" --button="Container Logs!docker.png":"bash -c click_four"  --window-icon="gtk" 

