#!/bin/bash
var="        <name>ActivitiesAccess</name>"
#var="ActivitiesAccess"
#cat sample.xml |sed 's/$var/XXX/g'
#newfapp=$(echo $1 | sed 's/\//\\\//g')
cat sample.xml |sed "s/$var/xxx/g"

