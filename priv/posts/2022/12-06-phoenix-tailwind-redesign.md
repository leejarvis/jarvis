%{
  title: "Phoenix Tailwind Redesign",
  summary: "Rebuilding with Phoenix and Tailwind"
}
---

As a software developer, I've had the opportunity to work with a variety of
technologies over the years. This website has always served as a subject for
experimenting with such tech — what better way to learn than to develop, maintain
and deploy something not only real, but in this case, very low-stakes.

As such, this website — and its predecessors — have evolved over the last 18 or
so years. From hand-crafted static HTML pages, to PHP, Perl CGI, modern JS frameworks
and back again to static HTML via tools like [Jekyll](https://jekyllrb.com/)
and [Nanoc](https://nanoc.app/).

It stood to reason then that the next evolution of the website would be built
with [Phoenix](https://www.phoenixframework.org/), the Elixir web framework I've
been using for the last few years for personal and work projects.

I _love_ building apps with Phoenix. I remember the feeling of using Rails 10+
years ago — the sense of immense joy assembling a prototype
in no more than and hour or two. That feeling for Rails has long dissipated,
and a Phoenix has risen, so to speak (sorry).

As mentioned in [recent weeknotes](/posts/2022/weeknotes-5-tongues-will-not-change-the-succession),
I've been keeping a keen eye on the frameworks development, and I've been excited
about the latest version, which brings [built-in Tailwind, Verified Routes and
more](https://phoenixframework.org/blog/phoenix-1.7-released).

Below are some notes about the build. If you're not interested in reading on,
you can also [check out the code on GitHub](https://github.com/leejarvis/jarvis).

## Database-less

It's important to me that this website does **not** depend on a database.
It adds an overhead I'm just not interested in maintaining. This meant I needed
to import my markdown posts from Jekyll in to this new system. That's easy
enough, but given that Elixir code requires a compilation step, I was concerned
that trying to build this in Phoenix might introduce some frustrating hurdles.

I was wrong, of course. The excellent [NimblePublisher](https://github.com/dashbitco/nimble_publisher)
library solves this with ease. My markdown files are not only processed during
the compilation stage and included as part of the application bundle, they're
watched for changes such that Phoenix will intelligently reload the page when I make
a change.

## Tailwind

Phoenix 1.7 introduces [Tailwind](https://tailwindcss.com/) support out of the box.
CSS isn't something I particularly enjoy writing, so Tailwind is a massive pleasure
to use. Furthermore, maintaining well-organised CSS is something of a nightmare.
Not really a problem for a tiny website like this, but I still have nightmares
from larger projects. Embedding styles in the markup and using [Phoenix
components](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html) is just
so nice.

The new design is based on the [Spotlight template](https://tailwindui.com/templates/spotlight).
I usually prefer designing stuff like this from scratch but I really like the
template defaults. I've changed bits here and there to give it my personal
touch, but the resemblance remains clear.

## Deployment

The website is deployed to [Fly.io](https://fly.io). I use Fly for several
production apps and they're stellar. Given the low traffic received here, I can't
imagine I'll ever need anything larger than the free tier, which is nice.

I may move the app to my Linode VPS at some point in future — which is where
I run a handful of Ruby and Go services. Just to give me a better look at what
a "native" deployment looks like. For now though I'm more than happy to let
Fly do the hard work.

The app is automatically deployed via a [GitHub
Workflow](https://github.com/leejarvis/jarvis/blob/main/.github/workflows/deploy.yml).

---

I used to think the idea of rebuilding my website every few years was silly.
Really though, it's the ideal way to sharpen skills and toy with new and
exciting technology; and Phoenix is about as exciting as it comes right now.
