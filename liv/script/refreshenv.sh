#!/bin/bash
. $HOME/.bash_profile
export BR=$1
export SCR=liv/script
export TS=$(date +%Y%m%d_%HH%M)
cd ../$BR
git push origin $BR:$BR
git pull origin $BR
$SCR/switchpkgdir.sh force-app
# wk
sfdx force:source:retrieve -x manifest/package.xml -u $BR
git add .
git commit -m "retrieve $BR Repo: $TS"
git push origin $BR:$BR

