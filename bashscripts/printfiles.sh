#!/bin/bash
#here it will open the magic file in etc/magic
found=false
# This is to check and open particular file
for i in /etc/*; do
  if [ $i = "/etc/magic" ]; then
    cat $i >> printed.txt
#if you want to store in another file    
    found=true
    break
  fi
done

if [ "$found" = false ]; then
   echo -n " No file found , OOPS!"
fi
