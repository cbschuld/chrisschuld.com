---
title: Search and Replace in Files
layout: post
categories: [Development, Linux]
tags: linux perl regex
redirect_from: /2008/01/search-and-replace-in-files
---

Here is how to do a search and replace using Perl regex over a set of files:
<br/><br/>
```bash
perl -pi -e 's/source/destination/g' *.ext
```