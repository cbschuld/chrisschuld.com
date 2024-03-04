---
title:  How to Get Modulus Info on an SSL Certificate
layout: post
categories: [Development, Linux]
tags: linux
redirect_from: /2007/07/how-to-get-modulus-info-on-an-ssl-certificate/
---

When your SSL keys and certificates fall out of sync let the headaches begin.

Here is a common error from apache&#58;
<strong>Error&#58; “Unable to configure RSA server private key”</strong>

Check to see if they are in sync using <a href="http://www.openssl.org/">openssl</a>. Compare the modulus values of both the key and the certificate. Here is how to get the modulus information out of the public key file and the certificate file:

Certificate File&#58;
```bash
openssl x509 -noout -text -in [certificate_filename] -modulus
```

Public Key File&#58;
```bash
openssl rsa -noout -text -in [public_key_filename] -modulus
```

