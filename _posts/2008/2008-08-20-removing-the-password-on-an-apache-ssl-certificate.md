---
title: Removing the Password on an Apache SSL Certificate
layout: post
categories: [Development, Linux]
tags: linux
redirect_from: /2008/08/removing-the-password-on-an-apache-ssl-certificate
---
Every once in a while I run across an SSL Cert with an included password.  Although the security is great automating an environment or an Apache restart with required interaction is problematic.

Here is an example of the interaction with a password included SSL Cert:

```bash
[root@w2 conf.d]# /etc/init.d/httpd restart
Stopping httpd:                                            [  OK  ]
Starting httpd: Apache/2.2.8 mod_ssl/2.2.8 (Pass Phrase Dialog)
Some of your private key files are encrypted for security reasons.
In order to read them you have to provide the pass phrases.
Server chrisschuld.com:443 (RSA)
Enter pass phrase:
OK: Pass Phrase Dialog successful.
```

And here is how you remove the password:

```bash
[root@w2 conf]# openssl rsa -in chrisschuld.com.key -out chrisschuld.com.key.nopass
```