#!/bin/bash

NC='\033[0m'
RED='\033[31m'

source ./colors.conf

fg_colors=(0 37 31 32 34 35 0)
bg_colors=(0 47 41 42 44 45 0)

color_name=(
    "null"
    "white"
    "red"
    "green"
    "blue"
    "purple"
    "black"
)

names=(
    "HOSTNAME"
    "TIMEZONE"
    "USER"
    "OS"
    "DATE"
    "UPTIME"
    "UPTIME_SEC"
    "IP"
    "MASK"
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

if [ $# != 0 ]
then
    echo -e "${RED}Error:${NC}: takes no arguments"
    exit 22
fi

if [[ -z "$column1_background" || -z  "$column1_font_color" || -z "$column2_background" || -z "$column2_font_color" ]]
then
    column1_background=6
    column1_font_color=2
    column2_background=6
    column2_font_color=3
elif [[ $column1_background != [1-6] || $column1_font_color != [1-6] || $column2_background != [1-6] || $column2_font_color != [1-6] ]]
then
    echo -e "${RED}Error:${NC}: wrong color configuration"
    exit 22
elif [[ $column1_background == $column1_font_color  || $column2_background == $column2_font_color ]]
then
    echo -e "${RED}Error:${NC}: wrong color configuration"
    exit 22
fi

declare -i I=0
for i in "${names[@]}"; do 
    printf "\e[%dm\e[%dm%s${NC} = \e[%dm\e[%dm%s${NC}\n"\
        "${bg_colors[$column1_background]}"\
        "${fg_colors[$column1_font_color]}"\
        "$i"\
        "${bg_colors[$column2_background]}"\
        "${fg_colors[$column2_font_color]}"\
        "$(eval "${ss[I]}")"
    I+=1
done

printf "Column 1 background = %d (%s)\n" $column1_background "${color_name[$column1_background]}"
printf "Column 1 font color = %d (%s)\n" $column1_font_color "${color_name[$column1_font_color]}"
printf "Column 2 background = %d (%s)\n" $column2_background "${color_name[$column2_background]}"                  
printf "Column 2 font color = %d (%s)\n" $column2_font_color "${color_name[$column2_font_color]}"
                                      
