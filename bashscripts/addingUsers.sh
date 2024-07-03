#!/bin/bash

#adding user to all the server

servers=$(cat inventory.txt)
#enter all the server hostname in the inventory file

echo -n "Enter your username "
read username
echo -n "end your userid"
read userid

#This loop will add user to the all the host in the inventory file
for i in $servers;do
   echo " adding user $username "
   sudo $i "sudo useradd -m -u $username $userid"
   if [ $? -eq 0 ]; then
   echo "user $username added successfully" 
   else 
   echo "error on adding $username"
   fi
done
