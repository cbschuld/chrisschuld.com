---
title: Installing docker and docker-compose on a Raspberry PI4 with Raspian
categories: [Development, Raspberry Pi]
layout: post
tags: docker pi
redirect_from: /2019/09/installing-docker-and-docker-compose-on-raspberry-pi4-with-raspian/
---

Installing the latest Docker on RPI4 is not straightforward because the versions on apt are old (currently).  Here is how you install current versions of both *docker* and *docker-compose*

## Installing Docker (docker)
```
curl -sL get.docker.com|sh
```

## Installing Docker Compose (docker-compose)

This installs all of the components needed to install *docker-compose* using *pip*.

*Warning:* this is NOT a fast process; it will take some time on the PI4

Using **Python3** (*suggested*):
```
sudo apt update
sudo apt install -y python3 python3-pip libffi-dev
sudo pip3 install docker-compose
```

Using **Python2**:
```
sudo apt update
sudo apt install -y python python-pip libffi-dev python-backports.ssl-match-hostname
sudo pip install docker-compose
```

## Updating Docker

To update *docker* you can simply run the install again.

```
sudo /etc/init.d/docker stop
curl -sL get.docker.com|sh
```

## Updating Docker Compose (docker-compose)
```
sudo apt install --upgrade python python-pip libffi-dev python-backports.ssl-match-hostname
sudo pip install --upgrade docker-compose
```
