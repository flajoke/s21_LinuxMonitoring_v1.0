#!/bin/bash

NC='\033[0m'
RED='\033[31m'

fg_colors=(0 37 31 33 34 35 0)
bg_colors=(0 47 41 43 44 45 0)

names=(
    "HOSTNAME"
    "TIMEZONE"
    "USER"
    "OS"
    "DATE"
    "UPTIME"
    "UPTIME_SEC"
    "IP" "MASK"
    "GATEWAY"
    "RAM_TOTAL"
    "RAM_USED"
    "RAM_FREE"
    "SPACE_ROOT"
    "SPACE_ROOT_USED"
    "SPACE_ROOT_FREE"
)

ss=(
    "hostname"
    "timedatectl | grep '/' | awk '{print \$3 \$4 \$5 }'"
    "echo "$USER" | awk                          '{print \$0}'"
    "cat /etc/issue | sed -r '/^\s*\$/d' | awk   '{print \$1,\$2,\$3}'"
    "date | awk                                  '{print \$3\" \"\$2\" \"\$6\" \"\$4}'"
    "uptime | awk                                '{print \$3}'"
    "cat /proc/uptime | awk                      '{print int(\$1)}'"
    "ifconfig | grep inet -m 1 | awk             '{print \$2}'"
    "ifconfig | grep netmask -m 1 | awk          '{print \$4}'"
    "ip r | grep default | awk                   '{print \$3}'"
    "free -m | awk                               '/Mem:/{printf \"%.3f Gb\n\", \$2/1024}'"
    "free -m | awk                               '/Mem:/{printf \"%.3f Gb\n\", \$3/1024}'"
    "free -m | awk                               '/Mem:/{printf \"%.3f Gb\n\", \$4/1024}'"
    "df /root/ | awk                             '/\/\$/  {printf \"%.2f MB\n\", \$2/1024}'"
    "df /root/ | awk                             '/\/\$/  {printf \"%.2f MB\n\", \$3/1024}'"
    "df /root/ | awk                             '/\/\$/  {printf \"%.2f MB\n\", \$4/1024}'"
)

if [ $# != 4 ]
then
    echo -e "${RED}Error:${NC}: incorrect argument count"
    exit 22
elif [[ $1 != [1-6] || $2 != [1-6] || $3 != [1-6] || $4 != [1-6] ]]
then
    echo -e "${RED}Error:${NC}: incorrect argumens"
    exit 22
elif [[ $1 == $2 || $3 == $4 ]]
then 
    echo -e "${RED}Error:${NC}: incorrect color comination"
    exit 22
fi

declare -i I=0
for i in "${names[@]}"; do 
    printf "\e[%dm\e[%dm%s${NC} = \e[%dm\e[%dm%s${NC}\n"\
        ${bg_colors[$1]}\
        ${fg_colors[$2]}\
        "$i"\
        ${bg_colors[$3]}\
        ${fg_colors[$4]}\
        "$(eval "${ss[I]}")"
    I+=1
done

