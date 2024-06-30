#!/bin/bash

#salary calculator
echo -n "Kindly enter your monthly salary:"
read salary
echo -n "Kindly enter your monthly tax in percent:"
read tax
tamt=$(echo "scale=2; $salary*($tax/100) " | bc -l )
total=$(echo "$tamt+$salary" | bc -l)
echo " Your total monthly salary is $total rupees "
