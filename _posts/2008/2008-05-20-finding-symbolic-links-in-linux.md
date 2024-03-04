---
title: Finding symbolic links in linux
layout: post
categories: [Development, Linux]
tags: linux
redirect_from: /2008/05/finding-symbolic-links-in-linux
---

I always have to use the man page of find to remember this -- hopefully writing it down will help.  Here is how you find all of the symbolic links in a linux path:

<pre lang="bash">find / -type l</pre>

