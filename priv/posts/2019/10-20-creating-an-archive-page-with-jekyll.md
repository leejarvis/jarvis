%{
  title: "Creating an Archive page with Jekyll",
  summary: "How to group Jekyll posts (by year or month) with minimal effort",
}
---

This website is built using [Jekyll](https://jekyllrb.com), a static
website builder written in Ruby.

There's a lot of static website builders
out there. I picked Jekyll because it's easy to use and extend (in
Ruby), and is supported by both
[GitHub Pages](http://pages.github.com) and
[Netlify](http://netlify.com), the latter
of which is used to host this website.

I recently added an [Archive page](/posts/archive) to show a list of posts
grouped by year. There's a number of ways you can do this, and I've seen
many hacky implementations on Stack Overflow. Thankfully it's
actually pretty easy.

Jekyll 3.4.0 introduced the `group_by_exp`
[Liquid Filter](https://jekyllrb.com/docs/liquid/filters/), allowing us to
group our posts according to the expression we pass as an argument. This
argument is itself a Liquid expression, allowing us to re-use Liquid filters.

Here's how to group our posts by year:

{% raw %}
```liquid
{% assign grouped_posts = site.posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% for year in grouped_posts %}
  <strong>{{ year.name }}</strong>
  <ul>
    {% for post in year.items %}
      <li>{{ post.title }}</li>
    {% endfor %}
  </ul>
{% endfor %}
```
{% endraw %}

We can even repeat our grouping inside the loop to include per-month
subheadings:

{% raw %}
```liquid
{% assign grouped_by_year = site.posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% for year in grouped_by_year %}
  <strong>{{ year.name }}</strong>
  {% assign grouped_by_month = year.items | group_by_exp: "post", "post.date | date: '%B'" %}
  {% for month in grouped_by_month %}
    <strong>{{ month.name }}</strong>
    <ul>
      {% for post in month.items %}
        <li>{{ post.title }}</li>
      {% endfor %}
    </ul>
  {% endfor %}
{% endfor %}
```
{% endraw %}

Whilst I'm not a huge fan of the Liquid syntax, Jekyll includes a number of really
convenient filters. It's worth checking out their [list](https://jekyllrb.com/docs/liquid/filters/)
when creating these sorts of pages.
