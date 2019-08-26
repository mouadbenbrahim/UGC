#!/bin/bash
cat liv/param/sfdx-project.template.json |sed "s/xxx/$1/g" > sfdx-project.toto.json
