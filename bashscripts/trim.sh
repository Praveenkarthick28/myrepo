#!/bin/bash

# This is to trim the input
echo -n "enter the word with asterisks mixed:"
read input 
#The user has to give input like : wel8888co8888me
str1=$(echo ${input//8})
str1=$(echo ${str1^^})
echo "updates string: ${str1}"
#It will print welcome
