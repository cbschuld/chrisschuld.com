---
title: Finding symbolic links in linux
description: "A quick reference for finding all symbolic links in a Linux directory path using the find command with the -type l option."
layout: post
categories: [Development, Linux]
tags: linux
redirect_from: /2008/05/finding-symbolic-links-in-linux/
---

I always have to use the man page of find to remember this -- hopefully writing it down will help.  Here is how you find all of the symbolic links in a linux path:

<pre lang="bash">find / -type l</pre>

