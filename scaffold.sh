#!/bin/bash
version="1.0"
#validate that the user passed the parameter
if [ -z "$1" ]
then
     echo "Please add the parameter to script ex: ./scaffold.sh blog"
    exit
fi
#get the project name parameter
projectName=$1
#set a list of directories to create
listOfDirectories="pages components store"
npm install --save-dev husky @testing-library/react @testing-library/dom @types/react @types/react-dom jest plop
npm install --save-dev --save-exact prettier
cp -a .prettierrc.js $projectName
cp -a .prettierignore $projectName
cp -a eslint.config.mjs $projectName
cp -a jest.config.js $projectName

cd $projectName
jq '.scripts.test:ci="jest --runInBand"' package.json | jq . | > package.json
jq '.scripts.generate="npx plop --plopfile generators/plopfile.js"' package.json | jq . | > package.json
jq '.scripts.prepare="husky"' package.json | jq . | > package.json
jq '.scripts.test:watch="jest --watch --maxWorkers=25%"' package.json | jq . | > package.json
echo "Generate directories"

cp -a /generators $projectName