#!/bin/bash

NC='\033[0m'
RED='\033[0;31m'

search_system() {
    hostname | awk '{print "HOSTNAME = " $0}'
    timedatectl | awk '{print "TIMEZONE = " $3 $4 $5}' | grep '/'
    echo "$USER" | awk '{print "USER = " $0}'
    cat /etc/issue | sed -r '/^\s*$/d' | awk '{print "OS = " $1,$2,$3}'
    date | awk '{print "DATE = " $3" "$2" "$6" "$4}'
    uptime | awk '{print "UPTIME = " $3}'
    cat /proc/uptime | awk '{print "UPTIME_SEC = " int($1)}'
    ifconfig | grep inet -m 1 | awk '{print "IP = " $2}'
    ifconfig | grep netmask -m 1 | awk '{print "MASK = " $4}'
    ip r | grep default | awk '{print "GATEWAY = " $3}'
    free -m | awk '/Mem:/{printf "RAM_TOTAL = %.3f Gb\n", $2/1024}'
    free -m | awk '/Mem:/{printf "RAM_USED = %.3f Gb\n", $3/1024}'
    free -m | awk '/Mem:/{printf "RAM_FREE = %.3f Gb\n", $4/1024}'
    df /root/ | awk '/\/$/  {printf "SPACE_ROOT = %.2f MB\n", $2/1024}'
    df /root/ | awk '/\/$/  {printf "SPACE_ROOT_USED = %.2f MB\n", $3/1024}'
    df /root/ | awk '/\/$/  {printf "SPACE_ROOT_FREE = %.2f MB\n", $4/1024}'
}

if [ $# != 0 ]
then
    echo -e "${RED}Error:${NC}: too many arguments"
else
    read -p "Write the output to a log file? (Y/N) " answer
    if [[ $answer == Y || $answer == y ]]
    then
        search_system > "$(date +"%d_%m_%y_%H_%M_%S").status"
    else
        search_system >&1
    fi
fi
