#!/bin/bash

# Help function
Help()
{
   # Display Help
   echo "Pass two arguments, first arg is platform, second is csv-File"
   echo
   echo "For example:"
   echo "./dockerize.sh mintos src/test/testdata/mintos.csv"
   echo
   echo "First arg: [mintos|estateguru|robocash|swaper|bondora|debitumnetwork|viainvest]"
   echo "Second arg: e.g. src/test/testdata/mintos.csv"
   echo
}

# Get the options
while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
   esac
done

# Test input arguments
if ! [[ $1 =~ ^(mintos|estateguru|robocash|swaper|bondora|debitumnetwork|viainvest)$ ]]
then
  echo "First argument must be from list below"
  echo
  Help
elif (($# != 2))
then
  echo "Number of arguments must be exactly 2"
  echo
  Help
elif [[ $2 != *.csv ]]
then
  echo "File extension must be .csv"
  echo
  Help
else 
  docker run -v ${PWD}/src:/python-docker/src pp-p2p-parser $1 $2
fi
