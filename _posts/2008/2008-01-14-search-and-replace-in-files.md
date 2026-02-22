---
title: Search and Replace in Files
description: "Learn how to perform a search and replace across multiple files using a simple Perl one-liner with regex support from the command line."
layout: post
categories: [Development, Linux]
tags: linux perl regex
redirect_from: /2008/01/search-and-replace-in-files/
---

Here is how to do a search and replace using Perl regex over a set of files:
<br/><br/>
```bash
perl -pi -e 's/source/destination/g' *.ext
```