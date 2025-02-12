#!/bin/bash
version="1.0"
#validate that the user passed the parameter
npm install --save-dev husky @testing-library/react @testing-library/dom @types/react @types/react-dom jest plop
npm install --save-dev --save-exact prettier
cp -a .prettierrc.js .prettierrc.js
cp -a .prettierignore .prettierignore
cp -a eslint.config.mjs eslint.config.mjs
cp -a jest.config.js jest.config.js

jq '.scripts[test:ci] = "jest --runInBand"' package.json > package.json
jq '.scripts.generate="npx plop --plopfile generators/plopfile.js"' package.json | jq . | > package.json
jq '.scripts.prepare="husky"' package.json | jq . | > package.json
jq '.scripts.test:watch="jest --watch --maxWorkers=25%"' package.json | jq . | > package.json
echo "Generate directories"

mkdir -p generators

cp -a /generators /generators