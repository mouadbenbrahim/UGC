#!/bin/bash
. $HOME/.bash_profile
export BR=$1
export SCR=liv/script
export TS=$(date +%Y%m%d_%HH%M)
cd ../$BR
echo "-- PUSH REPO $BR"
git push origin $BR:$BR
echo "-- PULL REPO $BR"
git pull origin $BR

