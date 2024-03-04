---
title: Parsing Out Specific Values In a Text File
layout: post
categories: [Development, Linux]
tags: linux regex
redirect_from: /2007/08/parsing-out-specific-values-in-a-text-file/
---

Another task which hits my desk often is getting "data" out of text files.  Such as names, email addresses, phone numbers, ID numbers, etc.  Here is a quick way to parse or rip out "data" from a text file.

I suggest using 'grep' -- grep is one of those applications which is more powerful than the casual user realizes.  And let's face it, if you use or know what grep is you probably do not consider yourself a casual user.

```bash
    grep -o -P "[regex_pattern]" [filename]
```

The -o tells grep to only output what it matched in your pattern where your &#91;regex_pattern&#93; is your pattern.
The -P tells grep to use Perl Regular Expressions

