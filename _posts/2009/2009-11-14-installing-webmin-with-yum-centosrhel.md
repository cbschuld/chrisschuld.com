---
title: Installing Webmin with YUM (CentOS,RHEL)
description: "Quick three-command guide to installing Webmin on CentOS or RHEL using YUM by adding the official Webmin repository and importing the GPG key."
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
