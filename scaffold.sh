#!/bin/bash
version="1.0"
sudo apt-get install jq
npm install --save-dev husky @testing-library/react @testing-library/dom @types/react @types/react-dom jest plop
npm install --save-dev --save-exact prettier

echo $(jq '.scripts["test:ci"] = "jest --runInBand"' package.json) | jq . | > package.json
echo $(jq '.scripts["generate"]="npx plop --plopfile generators/plopfile.js"') | jq . | package.json > package.json
echo $(jq '.scripts["prepare"]="husky"' package.json) | jq . | > package.json
echo $(jq '.scripts["test:watch"]="jest --watch --maxWorkers=25%"') | jq . | > package.json

# git clone --depth 1 git@github.com:faelribeiro22/scaffolder-files.git

#git archive --remote=<git@github.com:faelribeiro22/scaffolder-files.git> HEAD:path/to/directory/ filename | tar -t

git archive --remote=<git@github.com:faelribeiro22/scaffolder-files.git> | tar -t --exclude="*/*" | grep "/"