#!/bin/bash
cd $1/main/default/profiles/

echo "" > "Admin.profile-meta.xml"                        
echo "" > "Directeur du service client.profile-meta.xml"          
echo "" > "Salesforce_Nicolas.profile-meta.xml"
echo "" > "Chargé de clientèle Junior.profile-meta.xml"  
echo "" > "Guest License User.profile-meta.xml"                  
echo "" > "Salle - Dir de Cinéma.profile-meta.xml"
echo "" > "Chargé de Clientèle.profile-meta.xml"        
echo "" > "High Volume Customer Portal User.profile-meta.xml"     
echo "" > "Salle.profile-meta.xml"
echo "" > "Chatter External User.profile-meta.xml"       
echo "" > "Lecture Seule.profile-meta.xml"                        
echo "" > "SolutionManager.profile-meta.xml"
echo "" > "Chatter Free User.profile-meta.xml"            
echo "" > "Marketing.profile-meta.xml"                             
echo "" > "Standard.profile-meta.xml"
echo "" > "Chatter Moderator User.profile-meta.xml"       
echo "" > "MarketingProfile.profile-meta.xml"                      
echo "" > "Superviseur.profile-meta.xml"
echo "" > "chatter_SBE.profile-meta.xml"                  
echo "" > "Portail Client - Version d%27essai.profile-meta.xml"   
echo "" > "Synchro.profile-meta.xml"
echo "" > "ContractManager.profile-meta.xml"               
echo "" > "ReadOnly.profile-meta.xml"                             
echo "" > "System admin Easyfront.profile-meta.xml"

cd $1/main/default/permissionsets/
echo "" > "Case_Feed.permissionset-meta.xml"
echo "" > "Marketing_Cloud_Connected_App.permissionset-meta.xml"
echo "" > "Password_Never_Expires.permissionset-meta.xml"
echo "" > "UGC_Extra_admin.permissionset-meta.xml"
echo "" > "Viadialog_permission_set.permissionset-meta.xml"
echo "" > "Viadialog_permission_set_for_admin.permissionset-meta.xml"

cd -
