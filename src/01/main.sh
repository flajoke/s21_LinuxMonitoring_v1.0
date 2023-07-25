#!/bin/bash

regex='^[+-]?[0-9]+([.][0-9]+)?$'

NC='\033[0m' # No Color

#BLACK='\033[0;30m'
RED='\033[0;31m'
#GREEN='\033[0;32m'
#ORANGE='\033[0;33m'
#BLUE='\033[0;34m'
#PURPLE='\033[0;35m'
#CYAN='\033[0;36m'
#LGRAY='\033[0;37m'
#
#DGRAY='\033[0m'
#
#LRED='\033[1;31m'
#LGREEN='\033[1;32m'
#YELLOW='\033[1;33m'
#LBLUE='\033[1;34m'
#LPURPLE='\033[1;35m'
#LCYAN='\033[1;36m'
#WHITE='\033[1;37m'


if [ $# = 0 ]
then
    echo -e "${RED}Error:${NC} no arguments specified"
elif [[ $1 =~ $regex ]]
then
    echo -e "${RED}Error:${NC} Entered a number"
elif [ $# != 1 ]
then
    echo -e "${RED}Error:${NC} too many arguments"
else
    echo $1
fi

