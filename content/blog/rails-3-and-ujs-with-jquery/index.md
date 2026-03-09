---
title: Rails 3 and UJS with jQuery
date: '2010-11-28T08:56:00Z'
lastmod: '2010-11-28T09:01:02Z'
draft: false
tags:
- rails
- ujs
- jquery
author: 91.150.223.28
---

Recently I tried to convert my Rails 2.3 application into Rails 3.0. There are various tutorials
covering this problem, so I just concentrate on one issue which is not well described -
namely the UJS (Unobtrusive JavaScript) functionality introduced in Rails 3.

Generally I agree with the idea, that UJS is a good solution - the HTML we had with calls `link_to_remote`
and the like was really ugly, and this ugliness is not just something unimportant IMHO (especially when
you have to look at the page source). So I welcome this feature appreciatively.

So it seemed that the switch should to be as easy, as replacing the old:

```ruby
link\_to\_remote "tilte", :url =&gt; {...}, :update =&gt; "some\_id"
```

with

```ruby
link\_to "title", {...}, :remote =&gt; true
```

but... as you might see in this piece of code above, the `:update` key, which I found very useful, is missing
in the new syntax. I thought - "Strange", but who cares - there must be some rationale for that, just another
piece of Rails/jQuery magic. But when I started
[googling](http://www.google.pl/search?q=rails3+ujs&ie=utf-8&oe=utf-8&aq=t&rls=org.gentoo:en-US:unofficial&client=firefox-a),
I "discovered" that there is no good substitution for `:update`. Especially in
[Ryan's recent railscast](http://railscasts.com/episodes/240-search-sort-paginate-with-ajax) the solution
was really disappointing, I mean this line of code in `index.js.erb`:

```js
$("\#products").html("&lt;= escape\_javascript(render("products"))&gt;");
```

What?! Do I have to write this piece of sh... for every remote action? Where is the beauty of Rails' DRYness?

But just the next day after implementing this in my application,
I thought "There must be some solution for that". And there is!

\*If you wish to preserve the old behavior of `link_to_remote` without lousing the benefits of UJS, do
the same as you did, namely:\*

```ruby
link\_to "title", {...}, :remote =&gt; true, :"data-update" =&gt; "some\_id"
```

(We use `:"data-update"` instead of `:update` to be more HTML 5 compliant. You could use `:update`, but
then you would have to adapt the code below appropriately.)

**And then add this little piece of code to your `application.js`:**

```js
jQuery(function($) {
$("a\[data-update\]").live("ajax:success", function(data,status,xhr){
$("\#"+$(this).attr("data-update")).html(status);
});
});
```

And that's it! The `:update` behavior should work as previously (and don't ask me why I use "status" variable
for something which has semantic of "data" - the names are taken directly from the official `rails.js`
file).
