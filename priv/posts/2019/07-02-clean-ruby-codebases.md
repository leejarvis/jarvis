%{
  title: "Clean Ruby codebases",
  summary: "A few of my favourite Ruby codebases"
}
---

I enjoy reading code. Even the smallest snippet from a distant corner of
an obscure library or plugin could be enough to spark a new idea, and
at the very least it might evoke interest, repulsion (usually when reading my
old code), or simply teach me something new.

As the saying goes, code is read much more often than it is written. It takes
many years of experience to write great code, and nobody gets there without
having read a lot of it.

I started writing code before JavaScript became popular, when learning
HTML meant copying the contents of your favourite website's source code
and tweaking it to fit your purpose. New websites introduce new HTML tags
and CSS rules, long before the prominence of w3schools.

Naturally I became a bit stuck when I started learning server-side
languages. At the time I couldn't really afford the books; I really
wanted to sample everything and see what sticks.

Reading code I couldn't understand became regular, even nuking several
OS installs during my frivolous experimentations didn't stop me. I learned to
appreciate clean, well-written code before I could really write it myself.
GitHub eventually came along to make this experience effortless.

When speaking to new developers I have a few examples I use to
demonstrate what I appreciate as well-readable Ruby code. There's
a level of subjectivity to this of course, but for me, clean code:

* Is straightforward and obvious
* Is easy to digest
* Generally follows common style best-practices
* Is well structured
* Avoids too much magic/metaprogramming
* Contains comments only where they are helpful

So, without further ado, here are a few of my favourites:

**[Sidekiq](https://github.com/mperham/sidekiq/)**

Sidekiq is a library for processing background jobs. It's pretty much
considered the go-to tool for Ruby and Rails developers who want to store
their queue data in Redis. What is a fairly complex piece of software
is written so well that it basically holds your hand along the way.

**[Sequel](https://github.com/jeremyevans/sequel)**

Sequel is a database toolkit for Ruby. It's a strong replacement for
ActiveRecord and is my ORM of choice for non-Rails projects. It's 12
years old and was one of the first Ruby libraries I ever encountered.

**[Oga](https://gitlab.com/yorickpeterse/oga)**

Oga is an XML/HTML parser written in Ruby (crazy, right?). Whilst
Oga is no longer maintained, it remains a good example of nice-to-read
code.

**[Hanami](https://github.com/hanami/hanami)**

Hanami is a young Ruby web framework. It's designed to combat the extreme
bloat that Ruby on Rails introduces with its "everything including the
kitchen sink" approach. The project is split into smaller pieces making
it easy to digest and poke around.

**[HTTP](https://github.com/httprb/http)**

HTTP is my go-to Ruby library for making HTTP requests. It's fast, easy
to use (who on earth remembers the `net/http` syntax?), and with a lack
of "magic" code, it's really easy to understand what's happening under
the hood.

