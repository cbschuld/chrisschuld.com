---
title: Missing phpize?
layout: post
categories: [Development, Linux]
tags: fedora php
redirect_from: /2007/07/missing-phpize/
---

In an attempt to add the PECL <a href="http://pecl.php.net/package/uploadprogress" target="_blank">Upload Progress</a> package, I received  the following error:

```bash
[root@zebra cbschuld]# pecl install uploadprogress-beta
downloading uploadprogress-0.3.0.tgz ...
Starting to download uploadprogress-0.3.0.tgz (4,677 bytes)
.....done: 4,677 bytes
3 source files, building
running: phpize
sh: phpize: command not found
ERROR: `phpize' failed
```

Hmmm, it turns out I never added the package php-devel (oops).  If you are missing phpize on your machine add it with&#58;

```bash
yum install php-devel
```
