---
title: RHEL5 init (init.d) script for OpenOffice.org (2.3+)
layout: post
categories: [Development, Linux]
tags: linux centos fedora
redirect_from: /2008/10/rhel5-init-initd-script-for-openoffice-org
---

For a recent project I needed to perform document translations from DOC to PNG which requires an essential intermediate step to PDF.  The transformations required us to go to from DOC to PDF which can easily be done very nicely using openoffice 2.3 in a headless configuration.  The downside is you need a process running on a machine which you can connect to to make the transformation.

Here is the init.d script for starting up the soffice.bin (soffice) program in a headless mode&#58;
```bash
#!/bin/bash
# chkconfig: 345 20 80
# description: init.d script for headless openoffice.org (2.3+ for RHEL5 32bit)
#
# processname: soffice
#
# source function library
. /etc/rc.d/init.d/functions

RETVAL=0
SOFFICE_PATH='/usr/lib/openoffice.org/program'
SOFFICE_ARGS='-accept="socket,host=localhost,port=8100;urp" -headless -nofirststartwizard'
SOFFICE_PIDFILE=/var/run/soffice.bin.pid

start_soffice() {
       echo -n $"Starting OpenOffice.org"
       $SOFFICE_PATH/soffice.bin $SOFFICE_ARGS >/dev/null 2>&1 &
       [ $? -eq 0 ] && echo_success || echo_failure
       pidof soffice.bin & $SOFFICE_PIDFILE
       echo
}
start() {
       start_soffice
}
stop() {
       echo -n $"Stopping OpenOffice"
       killproc soffice.bin
       echo
}
case "$1" in
       start)
               start
               ;;
       stop)
               stop
               ;;
       restart)
               stop
               start
               ;;
       *)
               echo $"Usage: $0 {start|stop|restart}"
esac
```

NOTE: in 64bit the lib path has a '64' in it so

```bash
SOFFICE_PATH='/usr/lib/openoffice.org/program'
```

becomes

```bash
SOFFICE_PATH='/usr/lib64/openoffice.org/program'
```