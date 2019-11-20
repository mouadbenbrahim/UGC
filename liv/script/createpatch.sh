#!/bin/bash
#arguments: patch, c2aa8d(ancien), 5470cf(nouveau), UAT
export WORK_DIR=work/$1
export TGT_ENV=$4

rm -rRf work/$1

mkdir -p $WORK_DIR/fapp $WORK_DIR/fapp2/force-app $WORK_DIR/mdapi
# git diff $1 $2 --patch > $WORK_DIR/patch.p
# git apply $WORK_DIR/patch.p --directory=$WORK_DIR/fapp

# les fichiers deployer doivent etre dans le repertoire par defaut sfdx: force-app/
git diff $2 $3 --name-only | sed 's/\"//g' | tar -cvf - -T - | (cd ../DEVEF/$WORK_DIR/fapp/; tar xvf -)

# create empty files: profiles, permissionset, class meta
liv/script/createemptyprofiles.sh patch
# TODO: regler le pb de managesanboxes dans les prodiles

# ajouter les meta.xml pour les class: fichier vide.
liv/script/switchpkgdir.sh $WORK_DIR/fapp/force-app
sfdx force:source:convert -r $WORK_DIR/fapp/force-app -d $WORK_DIR/mdapi/
cp $WORK_DIR/mdapi/package.xml $WORK_DIR/package.xml
rm -rf $WORK_DIR/mdapi/*
liv/script/switchpkgdir.sh $WORK_DIR/fapp2/force-app
sfdx force:source:retrieve -x $WORK_DIR/package.xml  #on deploi depuis SF et non pas depuis git
sfdx force:source:convert -r $WORK_DIR/fapp2/force-app -d $WORK_DIR/mdapi/
# JOB_ID=$(sfdx force:mdapi:deploy -w 1 --checkonly -d $WORK_DIR/mdapi/ --targetusername $TGT_ENV --testlevel NoTestRun | grep 'jobid:' | sed 's/jobid:  //g')
liv/script/deploy.sh $TGT_ENV teste
echo "sfdx force:mdapi:deploy:report -i xxxxx -u $TGT_ENV"
echo "liv/script/deploy.sh $TGT_ENV run"
# sfdx force:mdapi:deploy -d $WORK_DIR/mdapi/ --targetusername $TGT_ENV --testlevel NoTestRun
