---
title: Setting the Timezones across all VPS's (OpenVZ)
layout: post
categories: [Development, Linux]
tags: openvz
redirect_from: /2009/10/setting-the-timezones-across-all-vps-openvz/
---

All of our servers are currently based off of the Phoenix, Arizona, USA Timezone.  This script allows this conversion from each HN (Host Node):

```bash

#!/bin/bash
for i in `vzlist | awk '{print $1}' | grep -v CTID`
do
  vzctl exec $f rm -f /etc/localtime 2>/dev/null
  vzctl exec $f ln -s /usr/share/zoneinfo/America/Phoenix /etc/localtime
done


```
