---
title: Removing Images from a WordPress Post
description: "Remove images from WordPress post content using PHP output buffering and preg_replace to strip img tags from the_content() output."
layout: post
categories: [Development, WordPress]
tags: wordpress
redirect_from: /2008/08/removing-images-from-a-wordpress-post/
---

Today I ran across a unique need to remove images from a WordPress post in a specific post loop.  Because there is no way to do a **read more** excerpt while taking strict control of the raw content from `the_content()` I was limited to capturing and manipulating the content from PHP&#39;s output buffer.  My solution&#58; obtain the output from `the_content()` and remove the image tags from the post using `preg_replace()`.

Here is the solution&#58;
```php
<?php
   ob_start();
   the_content('Read the full post',true);
   $postOutput = preg_replace('/<img[^>]+./','', ob_get_contents());
   ob_end_clean();
   echo $postOutput;
?>
```

**EDIT** &#58; make sure you check out the [updated version of this solution](https://chrisschuld.com/2009/04/removing-images-in-a-wordpress-post-revisited).  Also, view my solution for [removing everything but the images](https://chrisschuld.com/2009/11/removing-everything-but-images-in-a-wordpress-post).