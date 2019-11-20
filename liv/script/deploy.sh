#!/bin/bash

TGT_ENV=$1
ACTION=$2



if [ "$ACTION" == "run" ] 
then 
    echo "sfdx force:mdapi:deploy -d work/patch/mdapi/ --targetusername $TGT_ENV --testlevel NoTestRun"
else
    echo "sfdx force:mdapi:deploy -w 1 --checkonly -d work/patch/mdapi/ --targetusername $TGT_ENV --testlevel NoTestRun"
fi
