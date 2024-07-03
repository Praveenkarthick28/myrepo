#!/bin/bash

#This is to check the downtime of the servers

servers=$(cat inventory.txt)
#store all the server you want to check

for i in $servers; do
    ping $i >> /dev/null 2>&1
    if [ $? -eq 0 ]; then
    echo " $i is up and Running! "
    else 
    echo -n $i >>unreachable.txt
    fi
done

if [ -s unreachable.txt ]; then
    alerts=$(cat unreachable.txt)
    echo -n "$alerts are unreachable, kindly check" | mail -s "Host unreachable alerts" karthikjeeva619@gmail.com
    > unreachable.txt  # Clear the contents of the file after sending mail
else 
    echo " All the host are reachable" | mail -s "Infra health is good" karthikjeeva619@gmail.com 
fi
