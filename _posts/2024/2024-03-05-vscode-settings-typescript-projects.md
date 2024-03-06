---
title: Settings for Visual Studio Code (vscode) for TypeScript Projects
categories: [Development]
layout: post
tags: vscode
---

I prefer to allow Visual Studio Code to help adjust and modify the code as much as possible.  These are my go-to settings for Visual Studio Code (vscode) when I start a new Typescript Project (React, Serverless, etc):

The settings I leave in the `Workspace` at `./vscode/settings.json`

```json
{
  "editor.formatOnSave": true,
  "editor.formatOnPaste": false,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "files.exclude": {
    "node_modules/": true,
    "*/node_modules/": true,
    "**/node_modules/": true
  },
  "prettier.printWidth": 120,
  "editor.codeActionsOnSave": ["source.fixAll"],
  "eslint.validate": ["react", "html", "javascript", "typescript"]
}
```

Here is a description of the settings in use:

- `editor.formatOnSave (true)`: This setting enables automatic formatting of the code file upon saving. Whenever you save a file, VSCode will format it according to the rules specified by the default formatter.

- `editor.formatOnPaste (false)`: This disables automatic formatting of code when you paste it into a file. If this were set to true, pasting code would trigger the formatter to adjust the pasted content according to the formatting rules.

- `editor.defaultFormatter`: "esbenp.prettier-vscode": Specifies the default formatter to use for code formatting. I use Prettier ([esbenp.prettier-vscode](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)), one of the more popular code formatting tools.

- `files.exclude`: This configuration tells VSCode to exclude certain paths from the file explorer and searches. The node_modules/ directories at various levels (`node_modules/`, `*/node_modules/`, `**/node_modules/`) are excluded, making the editor interface cleaner and searches faster by ignoring these often large directories.

- `prettier.printWidth`: Sets the maximum line length (print width) that Prettier will wrap at to 120 characters. This influences how Prettier formats code, particularly in terms of line breaks.

- `editor.codeActionsOnSave [source.fixAll]`: This setting configures VSCode to automatically apply all possible fixes (like formatting and auto-fixable linting issues) on save. It's a broad setting that can trigger actions from multiple extensions to fix or format code upon saving.

- `eslint.validate`: ["react", "html", "javascript", "typescript"]: Configures ESLint, a static code analysis tool, to validate files of specified types: React, HTML, JavaScript, and TypeScript. This ensures your code adheres to best practices and style guidelines for these languages.


You can also create this file quickly from the command line in the project's root folder:

```shell
mkdir -p .vscode && echo '{
  "editor.formatOnSave": true,
  "editor.formatOnPaste": false,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "files.exclude": {
    "node_modules/": true,
    "*/node_modules/": true,
    "**/node_modules/": true
  },
  "prettier.printWidth": 120,
  "editor.codeActionsOnSave": ["source.fixAll"],
  "eslint.validate": ["react", "html", "javascript", "typescript"]
}' > .vscode/settings.json
```