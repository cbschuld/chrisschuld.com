---
title: Adding NFS support to an OpenVZ VPS
layout: post
categories: [Development, Linux]
tags: centos openvz
redirect_from: /2009/09/adding-nfs-support-to-an-openvz-vps/
---

I still use a lot of NFS connections on my equipment and when I create OpenVZ VPS systems I need them to have access to NFS.  Here are the steps I use:

From the Host Node (HN):
```bash
modprobe nfs
vzctl set 101 --features "nfs:on" --save
```

From the VPS:
```bash
yum -y install nfs-utils nfs-utils-lib
chkconfig --levels 345 portmap on
/etc/init.d/portmap start
```
