#!/bin/bash
version="1.0"

# Instala dependências do npm
npm install --save-dev husky @testing-library/react @testing-library/dom @types/react @types/react-dom jest plop
npm install --save-dev --save-exact prettier

# Clona o repositório com os arquivos de scaffolding
git clone --depth 1 https://github.com/faelribeiro22/scaffolder-files

# Define os scripts que você deseja adicionar ao package.json
declare -A scripts=(
  ["test:ci"]="jest --runInBand"
  ["generate"]="npx plop --plopfile generators/plopfile.js"
  ["prepare"]="husky"
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
  "scaffolder-files/generators"
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

# Remove a pasta scaffolder-files após mover os arquivos
rm -rf scaffolder-files

echo "Concluído!"