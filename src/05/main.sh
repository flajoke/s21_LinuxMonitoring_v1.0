#!/bin/bash

NC='\033[0m'
RED='\033[31m'

START=$(date +%s%N)
if [ $# != 1 ]
then
    echo -e "${RED}Error:${NC} Not enough arguemnts (L)"
elif [ ${1: -1} != "/" ]
then
    echo -e "${RED}Error:${NC} wrong argument (+ratio)"
else
    number_folders=$(find $1 -type d | wc -l)
    big_folders=$(du -Sh $1 | sort -rh | head -5 | cat -n | awk '{print $1" - "$3", "$2}')
    number_files=$(find $1 -type f | wc -l)
    conf_number_files=$(find $1 -type f -name "*.conf" | wc -l)
    exe_number_files=$(find $1 -type f -executable -exec du -h {} + | wc | awk '{ print $1 }')
    txt_number_files=$(find $1 -type f -name "*.txt" | wc -l)
    log_number_files=$(find $1 -type f -name "*.log" | wc -l)
    archive_number_files=$(find $1 -regex '.*\(tar\|zip\|gz\|rar\)' | wc -l )
    link_number_files=$(find $1 -type l | wc -l)
    file_types=$(file $1 | sort -rh | head -10)
    big_files=$(find $1 -type f -exec du -Sh {} + | sort -rh | head -10  | cat -n | awk '{print $1" - "$3", "$2", "$3}')
    big_exe_files=$(find $1 -type f -executable -exec du -h {} + | sort -hr | head -10 | cat -n | awk '{print $1" - "$3", "$2}')

    echo -e "Total number of folders (including all nested ones) = $number_folders"
    echo -e "TOP 5 folders of maximum size arranged in descending order (path and size):"
    echo "$big_folders"
    echo "Total number of files = $number_files"
    echo "Number of:"
    echo "Configuration files (with the .conf extension) = $conf_number_files"
    echo "Text files = $txt_number_files"
    echo "Executable files = $exe_number_files"
    echo "Log files (with the extension .log) = $log_number_files"
    echo "Archive files = $archive_number_files"
    echo "Symbolic links = $link_number_files"
    echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    echo "$big_files"
    echo "TOP 10 executable files of the maximum size arranged in descending order (path, size)"
    echo "$big_exe_files"
    END=$(date +%s%N)
    DIFF=$((( $END - $START )/1000000))
    echo "Script execution time (in milliseconds) = $DIFF"
fi
