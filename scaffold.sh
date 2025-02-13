#!/bin/bash
version="1.0"
npm install --save-dev husky @testing-library/react @testing-library/dom @types/react @types/react-dom jest plop
npm install --save-dev --save-exact prettier
git clone --depth 1 https://github.com/nome-do-usuario/nome-do-repositorio.git

# Define os scripts que você deseja adicionar
declare -A scripts=(
  ["test:ci"]="jest --runInBand"
  ["generate"]="npx plop --plopfile generators/plopfile.js"
  ["prepare"]="webpack --mode production"
  ["test:watch"]="jest --watch --maxWorkers=25%"
)

# Função para adicionar scripts ao package.json
add_scripts() {
  for key in "${!scripts[@]}"; do
    # Verifica se o script já existe
    if jq -e ".scripts[\"$key\"]" package.json > /dev/null; then
      echo "O script '$key' já existe no package.json. Pulando..."
    else
      # Adiciona o script ao package.json
      jq --arg key "$key" --arg value "${scripts[$key]}" '.scripts[$key] = $value' package.json > temp.json && mv temp.json package.json
      echo "Script '$key' adicionado com sucesso."
    fi
  done
}

# Executa a função para adicionar os scripts
add_scripts

# Lista de arquivos e pastas que você deseja mover
itens=(
  "scaffolder-files/.editorconfig"
  "scaffolder-files/.prettierignore"
  "scaffolder-files/.prettierrc"
  "scaffolder-files/eslint.config.mjs"
  "scaffolder-files/eslint.config.mjs"
)

# Loop para mover cada item para a pasta raiz
for item in "${itens[@]}"; do
  if [ -e "$item" ]; then
    mv "$item" .
    echo "Movido: $item para a pasta raiz."
  else
    echo "Aviso: $item não existe e foi ignorado."
  fi
done

rm -rf scaffolder-files

echo "Concluído!"

# echo $(jq '.scripts["test:ci"] = "jest --runInBand"' package.json) | jq . | > package.json
# echo $(jq '.scripts["generate"]="npx plop --plopfile generators/plopfile.js"') | jq . | > package.json
# echo $(jq '.scripts["prepare"]="husky"' package.json) | jq . | > package.json
# echo $(jq '.scripts["test:watch"]="jest --watch --maxWorkers=25%"') | jq . | > package.json

#jq '.scripts["test:ci"] = "jest --runInBand"' package.json | jq . | > package.json

# git clone --depth 1 git@github.com:faelribeiro22/scaffolder-files.git

#git archive --remote=<git@github.com:faelribeiro22/scaffolder-files.git> HEAD:path/to/directory/ filename | tar -t

# git archive --remote=git@github.com:faelribeiro22/scaffolder-files.git | tar -t --exclude="*/*" | grep "/"

setopt clobber