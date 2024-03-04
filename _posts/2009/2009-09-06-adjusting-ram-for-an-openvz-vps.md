---
title: Adjusting RAM for an OpenVZ VPS
layout: post
categories: [Development, Linux]
tags: openvz
redirect_from: /2009/09/adjusting-ram-for-an-openvz-vps
---

Here are commands to help adjust the memory / RAM for an OpenVZ VPS:

<strong>64MB Guaranteed, 128MB Burstable</strong>

```bash
cid=1000
vzctl set ${cid} --vmguarpages 64M --save
vzctl set ${cid} --oomguarpages 64M --save
vzctl set ${cid} --privvmpages 64M:128M --save
```

<strong>256MB Guaranteed, 512MB Burstable</strong>

```bash

cid=1000
vzctl set ${cid} --vmguarpages 256M --save
vzctl set ${cid} --oomguarpages 256M --save
vzctl set ${cid} --privvmpages 256M:512M --save
```

<strong>512MB Guaranteed, 1024MB Burstable</strong>

```bash
cid=1000
vzctl set ${cid} --vmguarpages 512M --save
vzctl set ${cid} --oomguarpages 512M --save
vzctl set ${cid} --privvmpages 512M:1024M --save
```

<strong>1024MB Guaranteed, 2048MB Burstable</strong>

```bash
cid=1000
vzctl set ${cid} --vmguarpages 1024M --save
vzctl set ${cid} --oomguarpages 1024M --save
vzctl set ${cid} --privvmpages 1024M:2048M --save
```
