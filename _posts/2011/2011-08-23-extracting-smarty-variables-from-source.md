---
title: Extracting Smarty variables from source
description: "Extract all Smarty template variables from source files using a simple grep command with a regex pattern to find every variable reference in .tpl files."
layout: post
categories: [Development]
tags: smarty
redirect_from: /2011/08/extracting-smarty-variables-from-source/
---

You can extract all of the variables in use from a Smarty template using a simple call to `*nix` grep with a trivial regex expression. Here is the command-

```bash
grep -o "\{\$[-_a-zA-Z0-9]*\}" my-template.tpl
```
