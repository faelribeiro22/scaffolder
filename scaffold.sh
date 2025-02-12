#!/bin/bash
version="1.0"
#validate that the user passed the parameter
npm install --save-dev husky @testing-library/react @testing-library/dom @types/react @types/react-dom jest plop
npm install --save-dev --save-exact prettier
cp -a .prettierrc.js dirname
cp -a .prettierignore dirname
cp -a eslint.config.mjs dirname
cp -a jest.config.js dirname

jq '.scripts.test:ci="jest --runInBand"' package.json | jq . | > package.json
jq '.scripts.generate="npx plop --plopfile generators/plopfile.js"' package.json | jq . | > package.json
jq '.scripts.prepare="husky"' package.json | jq . | > package.json
jq '.scripts.test:watch="jest --watch --maxWorkers=25%"' package.json | jq . | > package.json
echo "Generate directories"

cp -a /generators dirname

https://raw.githubusercontent.com/faelribeiro22/scaffolder/refs/heads/main/scaffold.sh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/faelribeiro22/scaffolder/refs/heads/main/scaffold.sh)"