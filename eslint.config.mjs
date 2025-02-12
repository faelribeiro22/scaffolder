import globals from 'globals'
import pluginJs from '@eslint/js'
import coreWebVitals from 'next/core-web-vitals'
import typescriptEslintParser from '@typescript-eslint/parser'
import typescriptEslint from '@typescript-eslint'
import typescriptRecommended from 'plugin:@typescript-eslint/recommended'
import reactRecommended from 'plugin:react/recommended'
import tseslint from 'typescript-eslint'
import pluginReactConfig from 'eslint-plugin-react/configs/recommended.js'
import eslintPluginPrettierRecommended from 'eslint-plugin-prettier/recommended'

/* eslint import/no-anonymous-default-export: [2, {"allowArray": true}] */
export default [
  {
    languageOptions: {
      globals: globals.browser,
      parser: typescriptEslintParser,
      parserOptions: { ecmaVersion: 'latest', sourceType: 'module' },
      plugins: typescriptEslint,
      rules: {
        'react-hooks/rules-of-hooks': 'error',
        'react-hooks/exhaustive-deps': 'warn',
        'react/prop-types': 'off',
        'react/react-in-jsx-scope': 'off',
        '@typescript-eslint/explicit-module-boundary-types': 'off'
      }
    },
    plugins: [
      coreWebVitals,
      typescriptEslintParser,
      typescriptRecommended,
      reactRecommended
    ]
  },
  eslintPluginPrettierRecommended,
  pluginJs.configs.recommended,
  ...tseslint.configs.recommended,
  pluginReactConfig
]
