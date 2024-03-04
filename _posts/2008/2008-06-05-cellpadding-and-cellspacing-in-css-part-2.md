---
title: Cellpadding and Cellspacing in CSS (part 2)
categories: [Development, CSS]
layout: post
tags: css xhtml
redirect_from: /2008/06/cellpadding-and-cellspacing-in-css-part-2/
---

Here is a follow up to the <a href="http://chrisschuld.com/2008/04/cellpadding-and-cellspacing-in-css/">cellpadding and cellspacing post</a> I made a while back.  The cellpadding and cellspacing can be completely controlled in CSS.  I realized today. I spoke only about collapsing the borders and not creating spacing `or the equivalent of cellspacing equal to something other than 0`.


Here are some HTML4 and CSS/XHTML equivalents&#58;


<strong>HTML4 :</strong>
```html

<table cellspacing="0" cellpadding="0">

```

<strong> CSS :</strong>
```css
table { border-collapse: collapse; }
table tr td { padding: 0px; }
```


<strong>HTML4 :</strong>
```html
<table cellspacing="2" cellpadding="0">
```

<strong> CSS :</strong>

```css
table { border-collapse: separate; border-spacing: 2px; }
table tr td { padding: 0px; }
```


<strong>HTML4 :</strong>

```html
<table cellspacing="2" cellpadding="2">
```

<strong> CSS:</strong>

```css
table { border-collapse: separate; border-spacing: 2px; }
table tr td { padding: 2px; }
```


You may want to place these definitions into a CSS class so you can quickly reference your table definition in XHTML&#58;


**CSS:**

```css
table.info { border: 1px solid #ccc; border-collapse: separate; border-spacing: 2px; }
table.info tr th { font-weight: normal; text-align: right; }
table.info tr td { font-weight: bold; padding: 2px; }
```


**HTML:**

```html
<table class="info">
  <tr><th>First Name:</th><td>Chris</td></tr>
  <tr><th>Last Name:</th><td>Schuld</td></tr>
</table>
```

Here is what it will look like:
```html
<table style="border: 1px solid #ccc; border-collapse: separate; border-spacing: 2px;" border="0">
<tbody>
<tr>
<th style="font-weight: normal;text-align: right;">First Name:</th>
<td style="font-weight: bold; padding: 2px;">Chris</td>
</tr>
<tr>
<th style="font-weight: normal;text-align: right;">Last Name:</th>
<td style="font-weight: bold; padding: 2px;">Schuld</td>
</tr>
</tbody></table>
```