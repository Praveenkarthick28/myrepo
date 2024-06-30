#!/bin/bash

#This is to print the content in upper case

echo " printing the content in upper case "
#########################################################
cat $1 | tr [:lower:] [:upper:]
