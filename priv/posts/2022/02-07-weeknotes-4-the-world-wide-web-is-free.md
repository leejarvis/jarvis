%{
  title: "The world wide web is free",
  summary: "Weeknotes 4",
}
---

This last week has felt like the first "normal" one of the year. I think it's because I've had a full week of uninterupted work. Although perhaps not the best metric for measuring normality, I welcome the peace after a busy January. I've been effective at work _and_ maintained a good work/life balance. Imagine!

I did visit the dentist though, which isn't something I particularly enjoy doing. I need a couple of fillings, which wasn't a great surprise. Otherwise things are pretty healthy. The dentist didn't disappoint though and was sure to give me the classic grilling on not brushing enough in some places (has anyone ever _not_ received this? I'm fucking bored of being told off every time I go).

---

We have unwelcome mice in our loft space. At least I assume they're mice. Or a lone mouse. We can hear the tippy-tappy footsteps scurrying above our master bedroom -- it's particularly noisy right before bed. I like to think that Remy from Ratatouille is up there having fun. More realistically, it's some feral bastard rubbing feces all over the place.

We're having some loft boarding installed next week because we need some extra storage (not to block the mouse in, promise). We'll see what that does to its movements before taking any further action.

---

I finally found a dry enough day to mown the lawn! That's it. That's the whole paragraph.

---

Unfortunately the lease car I placed on order last November has extended its build date from April to October/November ("or beyond"). How on earth a lease company can claim an estimated date that is inaccurate by 6+ months boggles the mind, but it appears the world-wide chip shortage brings unprecedented lead times.

Unfortunately we have to own a car because of where we live. We have gone the entire pandemic without a second car though, but that's going to be coming to an end in the next 4-6 months. Especially now that Vicky is getting back to work. I feel like I'm 1-2 years too early for an electric car I don't feel ashamed about getting in (yeah I know, but seriously, why do they all have to look like ass?). Shopping for cars is depressing, honestly. We're remortgaging later this year too which makes financing a little more complicated. A first-world problem, but a problem nonetheless.

---

I deployed the Ruby 3 upgrade at Spark! Really pleased to finally get this out. The branch had a lot of changes (mostly related to the [separation of positional and keyword arguments](https://www.ruby-lang.org/en/news/2019/12/12/separation-of-positional-and-keyword-arguments-in-ruby-3-0/)) but the deploy itself went off without a hitch. Next up: Ruby 3.1 and maybe even some [pattern matching additions](https://leejarvis.me/posts/2022/ruby-3-pattern-matching). I'd also like to upgrade to Rails 7 in the next few months (up from 6.1).

In addition to the Ruby upgrade, I created a new `bin/dev` script to match what Rails does in version 7 (runs your dev server). This made me think about creating a unified interface for managing and communicating with the application as bin scripts. I subsequently added a `bin/deploy` script that allows us to customise our capistrano deploy and I plan on adding things like `bin/console` and improving our `bin/setup` -- this really helps reduce our documentation burden, especially when these scripts are interactive.

I created a new Asana Project for managing our technical debt! This was satisfying, and it was well received across the team. I'll be working on adding descriptions to these tasks and creating a priority order over the coming weeks. It feels good to get moving on this.

---

The folks over at Fly.io (and in particular, Chris McCord -- the creator of the Phoenix Web Framework) have been working on a full-stack Phoenix reference app called [LiveBeats](https://fly.io/blog/livebeats/). This has already proved a useful resource for approaching basic Phoenix problems, and also demonstrates the cool factor of multi-region Fly applications. Highly recommend taking a look. I even [created a tiny PR for them](https://github.com/fly-apps/live_beats/pull/33).

I've also deployed my first "proper" Fly application this week; a wedding website for a friend (I'm the best man at their wedding). It didn't quite go without a hitch, but when things work as smoothly as intended, it really feels like magic.

---

Rugby is back in the form of the Six Nations. The kiddo (who loves her weekly visits to the Rugby Tots club) noticed similarities and I think she's already hooked.

We finished watching Ozark which was good, and also started and finished [Maid](https://en.wikipedia.org/wiki/Maid_(miniseries)), which is probably one of the best Netflix series we've watched -- it is fantastic.

Also started Station Eleven (good and weird) and Pam & Tommy (bad and weird).

[Sony bought Bungie](https://www.bungie.net/en/News/Article/50988). Not sure how to feel about this one; it's one of my favourite games and I really hope they stick to their promise of having creative freedom. Especially for the Next Big Thing they launch after Destiny 2 concludes.
