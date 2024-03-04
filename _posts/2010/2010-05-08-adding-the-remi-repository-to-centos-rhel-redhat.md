---
title: Adding the REMI Repository to CentOS / RHEL / RedHat
layout: post
categories: [Development, Linux]
tags: linux centos
redirect_from: /2010/05/adding-the-remi-repository-to-centos-rhel-redhat/
---

I am a fan of the REMI Repository. Here are the steps necessary to add, enable and then update your box w/ the latest packages from the REMI Repository.

```bash
wget http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-4.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-5.rpm
rpm -Uvh remi-release-5*.rpm epel-release-5*.rpm
/bin/rm epel-release-5-4.noarch.rpm remi-release-5.rpm

perl -pi -e 's/enabled=0/enabled=1/g' /etc/yum.repos.d/remi.repo

yum update

```

*UPDATED - 2010-08-29:* Location Updated for the epel-release file
