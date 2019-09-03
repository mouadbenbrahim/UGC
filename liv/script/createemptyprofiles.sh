#!/bin/bash

export FAPP_DIR=work/$1/fapp/force-app
export CLASS_DIR=$FAPP_DIR/main/default/classes
#if [ ! -d "$FAPP_DIR/main/default/profiles" ]; then mkdir -p $FAPP_DIR/main/default/profiles; fi

mkdir -p $FAPP_DIR/main/default/profiles
mkdir -p $FAPP_DIR/main/default/permissionsets/

rm -rf $FAPP_DIR/main/default/profiles/*
rm -rf $FAPP_DIR/main/default/permissionsets/*

echo "" > $FAPP_DIR/main/default/profiles/"Admin.profile-meta.xml"                        
echo "" > $FAPP_DIR/main/default/profiles/"Directeur du service client.profile-meta.xml"          
echo "" > $FAPP_DIR/main/default/profiles/"Salesforce_Nicolas.profile-meta.xml"
echo "" > $FAPP_DIR/main/default/profiles/"Chargé de clientèle Junior.profile-meta.xml"  
echo "" > $FAPP_DIR/main/default/profiles/"Guest License User.profile-meta.xml"                  
echo "" > $FAPP_DIR/main/default/profiles/"Salle - Dir de Cinéma.profile-meta.xml"
echo "" > $FAPP_DIR/main/default/profiles/"Chargé de Clientèle.profile-meta.xml"        
echo "" > $FAPP_DIR/main/default/profiles/"High Volume Customer Portal User.profile-meta.xml"     
echo "" > $FAPP_DIR/main/default/profiles/"Salle.profile-meta.xml"
echo "" > $FAPP_DIR/main/default/profiles/"Chatter External User.profile-meta.xml"       
echo "" > $FAPP_DIR/main/default/profiles/"Lecture Seule.profile-meta.xml"                        
echo "" > $FAPP_DIR/main/default/profiles/"SolutionManager.profile-meta.xml"
echo "" > $FAPP_DIR/main/default/profiles/"Chatter Free User.profile-meta.xml"            
echo "" > $FAPP_DIR/main/default/profiles/"Marketing.profile-meta.xml"                             
echo "" > $FAPP_DIR/main/default/profiles/"Standard.profile-meta.xml"
echo "" > $FAPP_DIR/main/default/profiles/"Chatter Moderator User.profile-meta.xml"       
echo "" > $FAPP_DIR/main/default/profiles/"MarketingProfile.profile-meta.xml"                      
echo "" > $FAPP_DIR/main/default/profiles/"Superviseur.profile-meta.xml"
echo "" > $FAPP_DIR/main/default/profiles/"chatter_SBE.profile-meta.xml"                  
echo "" > $FAPP_DIR/main/default/profiles/"Portail Client - Version d%27essai.profile-meta.xml"   
echo "" > $FAPP_DIR/main/default/profiles/"Synchro.profile-meta.xml"
echo "" > $FAPP_DIR/main/default/profiles/"ContractManager.profile-meta.xml"               
echo "" > $FAPP_DIR/main/default/profiles/"ReadOnly.profile-meta.xml"                             
echo "" > $FAPP_DIR/main/default/profiles/"System admin Easyfront.profile-meta.xml"

# cd $FAPP_DIR/main/default/permissionsets/
echo "" > $FAPP_DIR/main/default/permissionsets/"Case_Feed.permissionset-meta.xml"
echo "" > $FAPP_DIR/main/default/permissionsets/"Marketing_Cloud_Connected_App.permissionset-meta.xml"
echo "" > $FAPP_DIR/main/default/permissionsets/"Password_Never_Expires.permissionset-meta.xml"
echo "" > $FAPP_DIR/main/default/permissionsets/"UGC_Extra_admin.permissionset-meta.xml"
echo "" > $FAPP_DIR/main/default/permissionsets/"Viadialog_permission_set.permissionset-meta.xml"
echo "" > $FAPP_DIR/main/default/permissionsets/"Viadialog_permission_set_for_admin.permissionset-meta.xml"

# cd -

# create empty class meta files
FILES=$CLASS_DIR/*
for f in $FILES
do
  echo "Processing $f file..."
  echo "" > $f-meta.xml
  #ls $f
done
