#!/bin/bash
version="1.0"
#validate that the user passed the parameter
npm install --save-dev husky @testing-library/react @testing-library/dom @types/react @types/react-dom jest plop
npm install --save-dev --save-exact prettier

jq '.scripts["test:ci"] = "jest --runInBand"' package.json > package.json
jq '.scripts["generate"]="npx plop --plopfile generators/plopfile.js"' package.json > package.json
jq '.scripts["prepare"]="husky"' package.json | jq . | > package.json
jq '.scripts["test:watch"]="jest --watch --maxWorkers=25%"' package.json > package.json

# git clone --depth 1 git@github.com:faelribeiro22/scaffolder-files.git

#git archive --remote=<git@github.com:faelribeiro22/scaffolder-files.git> HEAD:path/to/directory/ filename | tar -t

git archive --remote=<git@github.com:faelribeiro22/scaffolder-files.git> | tar -t --exclude="*/*" | grep "/"