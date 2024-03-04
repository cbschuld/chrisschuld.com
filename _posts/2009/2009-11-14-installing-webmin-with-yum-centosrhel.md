---
title: Installing Webmin with YUM (CentOS,RHEL)
layout: post
categories: [Development, Linux]
tags: openvz
redirect_from: /2009/11/installing-webmin-with-yum-centosrhel/
---
Here are the commands to install Webmin via Yum:

```bash
echo -e "[Webmin]\nname=Webmin Distribution Neutral\nbaseurl=http://download.webmin.com/download/yum\nenabled=1" > /etc/yum.repos.d/webmin.repo
rpm --import http://www.webmin.com/jcameron-key.asc
yum install webmin
```
