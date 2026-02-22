---
title: Cellpadding and Cellspacing in CSS
description: "Learn how to replace deprecated HTML cellpadding and cellspacing table attributes with CSS using border-collapse for modern web development."
categories: [Development, CSS]
layout: post
tags: 
redirect_from: /2008/05/cellpadding-and-cellspacing-in-css/
---

Those of us who learned HTML early in the game are familiar with HTML table parameters <strong>cellpadding</strong> and <strong>cellspacing</strong>.  In a positive way they were deprecated in HTML4 so you must use CSS to control the padding and spacing now.

Here is how you do it in CSS:

<pre lang="css"> border-collapse: collapse;</pre>

A nice line to place in your global CSS file (if you use one) is:

```csstable { border-collapse: collapse; }```
