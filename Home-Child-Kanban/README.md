# SFDX  App

## convert from classic mdapi
cd Home-Child-Kanban
sfdx force:mdapi:convert -r ../src

sfdx force:mdapi:deploy -d ../src -w 100

## Dev, Build and Test

sfdx force:org:create -s -f config/project-scratch-def.json -a "Kanban"
sfdx force:source:push
sfdx force:org:open

sfdx force:user:permset:assign -n "Kanban"

## Resources


## Description of Files and Directories


## Issues


