#!/usr/bin/env bash

set -- $(df -h | awk '$NF=="/"{print $2" "$3" "$5}')

total=$1
used=$2
used_percent=${3::-1}
error_limit=95
warning_limit=80

printf "INFO - disk usage %s/%s (%s%%)\n" $used $total $used_percent

if [ $used_percent -gt $error_limit ]; then
 echo "ERROR - threshold is reached!"
 exit 2
elif [ $used_percent -gt $warning_limit ]; then
 echo "WARNING - some space is left!"
 exit 1
fi

echo "OK - disk usage is under $warning_limit%"
