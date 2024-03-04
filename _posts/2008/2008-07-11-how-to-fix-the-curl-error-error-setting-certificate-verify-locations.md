---
title: How to fix the Curl Error&#58; error setting certificate verify locations
layout: post
categories: [Development, Linux]
tags: centos
redirect_from: /2008/07/how-to-fix-the-curl-error-error-setting-certificate-verify-locations/
---

Today I had a new server running CentOS5 have trouble with a known good authorize.net library using curl.  It was producing the following error&#58;

```bash
error setting certificate verify locations: CAfile: /etc/pki/tls/certs/ca-bundle.crt CApath: none
```

After some research I found it was based on the inability for the apache user to access the ca-bundle.crt file.  You will find solutions on the web suggesting adding <em>curl_setopt($link, CURLOPT_SSL_VERIFYPEER, FALSE);</em> to your script to disable the peer verification -- I suggest you <strong>not</strong> do this and simply fix the permissions for your CA file.

Execute this&#58;
```bash
/bin/chmod 755 /etc/pki/tls/certs
```

Solved!