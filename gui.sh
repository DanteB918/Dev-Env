#! /bin/bash




wp(){ #WORDPRESS
            click_one(){ #Start/Restart WP
            RED='\033[0;31m'
            NC='\033[0m' # No Color

               echo -e "\nNow Creating your wordpress website...\n"

            if [[ $(ss -tulpn | grep 5080) ]];then
                  echo "Port 5080 is already allocated. Attempting to decompose the wordpress site on the port."
                  echo -e "\n Decomposing.."
                  $(ANSIBLE_LOCALHOST_WARNING=false ansible-playbook .dewordpress.yml | yad --title="Decomposing" --progress --pulsate --auto-close)
                           if [[ $(ss -tulpn | grep 5080) ]];then #See if port 5080 is allocated
                                    echo "PORT IS STILL ALLOCATED, please close containers from something else"
                                    
                           fi
                  echo -e "\nSuccessfully composed down containers. now re-composing."
               
            fi

            $(ANSIBLE_LOCALHOST_WARNING=false ansible-playbook .wordpress.yml | yad --title="Composing up..." --progress --pulsate --auto-close)


            echo -e "Site created\n\n Here are your container names.\n"
            echo $(docker ps | awk '{print $NF}')

            echo -e "\nPlease visit ${RED}http:localhost:5080${NC} in order to view your site."
            exit
            }

            click_two(){ #Stop WP
                  echo -e "\n Decomposing.."

                                    if [[ $(ss -tulpn | grep 5080) ]];then #See if port 5080 is allocated
                                    $(ANSIBLE_LOCALHOST_WARNING=false ansible-playbook .dewordpress.yml | yad --title="Decomposing" --progress --pulsate --auto-close)


                                    echo -e "\nSuccessfully composed down containers."
                                 
                                 else
                                 $(yad --title="Decomposing" --text="No containers to decompose on port 5080")
                                    echo "No containers to decompose on port 5080"

                                    fi

               exit
            }
            click_three(){ # Show All Running containers
               contz=$(docker ps)
               yad --text="$contz" --title="CONTAINERS"

            }
            click_four(){ #Get Container logs
               logs=$(docker logs  wordpress-wordpress-1 &> log.txt) # Saving docker logs for container to log.txt
               log=$(cat log.txt)
               yad --title="CONTAINER LOGS:" --height=500 --button="GET LOGS":"bash -c click_four" --text="$log"
               $(rm log.txt) # Removing log.txt so if they get container logs, it will only show the new.
            }

            export -f click_one click_two click_three click_four


            #The GUI:
            yad --text-align="center" --center --title="Local Wordpress Setup" --text="\nLocal environment set-up. Choose your option.\n For more info, see the terminal.\n" \
            --button="Start/Restart!wordpress-icon.png":"bash -c click_one" --button="Stop!wordpress-icon.png":"bash -c click_two" --button="Show all Containers!docker.png":"bash -c click_three" --button="Container Logs!docker.png":"bash -c click_four"  --window-icon="gtk"

}

ngx(){ #NGINX
        click_one(){ #Start/Restart WP
            RED='\033[0;31m'
            NC='\033[0m' # No Color

               echo -e "\nNow Creating your website...\n"

            if [[ $(ss -tulpn | grep 5080) ]];then
                  echo "Port 5081 is already allocated. Attempting to decompose the site on the port."
                  echo -e "\n Decomposing.."
                  $(ANSIBLE_LOCALHOST_WARNING=false ansible-playbook .denginx.yml | yad --title="Decomposing" --progress --pulsate --auto-close)
                           if [[ $(ss -tulpn | grep 5081) ]];then #See if port 5081 is allocated
                                    echo "PORT IS STILL ALLOCATED, please close containers from something else"
                                    
                           fi
                  echo -e "\nSuccessfully composed down containers. now re-composing."
               
            fi

            $(ANSIBLE_LOCALHOST_WARNING=false ansible-playbook .nginx.yml | yad --title="Composing up..." --progress --pulsate --auto-close)


            echo -e "Site created\n\n Here are your container names.\n"
            echo $(docker ps | awk '{print $NF}')

            echo -e "\nPlease visit ${RED}http:localhost:5081${NC} in order to view your site."
            exit
            }

            click_two(){ #Stop NGINX
                  echo -e "\n Decomposing.."

                                    if [[ $(ss -tulpn | grep 5081) ]];then #See if port 5081 is allocated
                                    $(ANSIBLE_LOCALHOST_WARNING=false ansible-playbook .denginx.yml | yad --title="Decomposing" --progress --pulsate --auto-close)


                                    echo -e "\nSuccessfully composed down containers."
                                 
                                 else
                                 $(yad --title="Decomposing" --text="No containers to decompose on port 5081")
                                    echo "No containers to decompose on port 5081"

                                    fi

               exit
            }
            click_three(){ # Show All Running containers
               contz=$(docker ps)
               yad --text="$contz" --title="CONTAINERS"

            }
            click_four(){ #Get Container logs
               logs=$(docker logs  nginx-nginx-1 &> log.txt) # Saving docker logs for container to log.txt
               log=$(cat log.txt)
               yad --title="CONTAINER LOGS:" --height=500 --button="GET LOGS":"bash -c click_four" --text="$log"
               $(rm log.txt) # Removing log.txt so if they get container logs, it will only show the new.
            }

            export -f click_one click_two click_three click_four


            #The GUI:
            yad --text-align="center" --center --title="Local Nginx Setup" --text="\nLocal environment set-up. Choose your option.\n For more info, see the terminal.\n" \
            --button="Start/Restart!nginx.png":"bash -c click_one" --button="Stop!nginx.png":"bash -c click_two" --button="Show all Containers!docker.png":"bash -c click_three" --button="Container Logs!docker.png":"bash -c click_four"  --window-icon="gtk"
}



export -f wp ngx


#The GUI:
yad --text-align="center" --center --title="Local Dev Environment Setup" --text="\nPlease choose the platform. \n" \
--button="Wordpress!wordpress-icon.png":"bash -c wp" --button="Nginx!nginx.png":"bash -c ngx"  --window-icon="gtk"
















