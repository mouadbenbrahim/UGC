#!/bin/bash
# newfapp="ff";
# echo $1 | sed 's/\//\\\//g';
newfapp=$(echo $1 | sed 's/\//\\\//g')
cat liv/param/sfdx-project.template.json |sed "s/xxx/$newfapp/g" > sfdx-project.json
## echo "--$newfapp--";
