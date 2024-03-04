---
title: Stopping the screen blanking on the command line in linux
layout: post
categories: [Development, Linux]
tags: linux
redirect_from: /2008/11/stopping-the-screen-blanking-on-the-command-line-in-linux/
---

We have a server in my office we reference a lot.  After X time period it would fall asleep and someone would have to hit the keyboard to see the latest information.  After digging for a bit (and never really finding the answer) I figured it out and decided to document it because I will forget next time this occurs!

```bash

setterm -blank 0
setterm -powersave off

```

You have to do this from the terminal console and not a remote shell (which, would actually make no sense) or you will see this message:

```bash
cannot (un)set powersave mode
```