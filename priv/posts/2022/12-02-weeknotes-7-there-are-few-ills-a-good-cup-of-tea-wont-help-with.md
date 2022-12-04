%{
  title: "There are few ills a good cup of tea won’t help with",
  summary: "Weeknotes 7"
}
---

It is cold and I have a cold. Autumn, I'm sorry I didn't appreciate you enough.

---

I've had some laptop woes this week. I grabbed my MacBook and headed to the
local library to seek out some peace and quiet, only to find that the macOS beta
had basically hosed the computer. Apple ID login was broken, the Settings app
was completely messed up and I couldn't connect to the library WiFi due to some
weird DNS issues. I know it's a beta and I should have known better, but this was
pretty disappointing.

No more disappointing than the library being the noisiest place on earth though.

In happier news — and after resetting the MacBook — I used migration assistant to
duplicate the contents of my desktop computer and it worked perfectly. Took a
few hours, but everything is there, preferences included.

---

I learned about **Fire Toolbox**, a tool built to fix FireOS, the monstrosity of an operating
system on Amazon's Fire tablet range. We have one of these tablets for our daughter
and it is absolutely riddled with adverts, including the screensaver. WTF? Fire Toolbox
helped remove a lot of this garbage and let me install Google Play, which is marginally
better — though don't get me started on the despicable range of children's apps that
are filled with ads and sneaky in-app purchases (looking at you too, Apple).

The official [Tailwind Components](https://tailwindui.com/components) package went on
sale for Black Friday and I decided to scoop it up for work. I've been a huge fan of
Tailwind so far, and given its default integration with the latest version of the
Phoenix framework, I could see myself using it more often in future. I'm
working on a new version of this website using this tech and it's been good fun so far.

I learned about [Raycast](https://www.raycast.com/) — an excellent macOS app that's
similar to Alfred (or Spotlight). Not only has this app replaced Alfred, but the
built-in window and clipboard management tools allowed me to replace two other
apps. I don't know why they're not charging for some of these features but I have
been incredibly impressed so far.

---

[Advent of code](https://adventofcode.com/) is back! Suffice to say that
[I am a big fan](/posts/2019/advent-of-code) of these coding challenges.

---

I recently learned that the Ruby [Papertrail](https://github.com/paper-trail-gem/paper_trail) gem
[captures versions even when there are no object changes](https://stackoverflow.com/questions/54788701/paper-trail-gem-saving-versions-with-object-changes-nil),
which meant our work database was filled with a lot of useless data. Almost 100 million rows,
in fact — which is more than 60% of the total table size. Removing them took some
time, but it was incredibly cathartic.

This investigation began off the back of a significant outage, caused by some
rogue database queries working away indefinitely (and being spawned/duplicated by
web page reloads). Turns out we've managed to last 10+ years without having a fixed
database timeout configured. Oops.

---

I moved my Mastodon account from Ruby.social to [Hachyderm](https://hachyderm.io/@leejarvis).
I'd been browsing different servers for a while and wanted to settle on one that was more general.
They've had some scaling woes over the last few days but have dealt with them very well, and very
[openly](https://medium.com/@kris-nova/experimenting-with-federation-and-migrating-accounts-eae61a688c3c).
Seems like a nice little community so far.

---


I've spent some time investigating new RSS/Read Later apps and tested the following:

- [Alfread](https://alfreadapp.com)
- [Pocket](https://getpocket.com/)
- [ReadKit](https://readkit.app/)
- [Inoreader](https://www.inoreader.com/)
- [Matter](https://hq.getmatter.app/)

The summary so far is that most of these apps are either over-engineered or they are missing
some crucial features. **ReadKit** is probably my favourite at the moment but I'm pretty
close to just sticking with [NetNewsWire](/posts/2020/netnewswire) despite it not having
_Read Later_ capabilities.

---

I finished watching **The Crown** and can't help but feel disappointed. The narrative exposition
feels very forced and clunky. For a season filled with momentous events, the story is unnecessarily
narrow and yet overtly theatrical. If there was a season to point at as _fictional dramatisation_,
this one was it.

The new season of **Mythic Quest** isn't much better, but at least it's shorter.

I started watching **The Peripheral** and thought the pilot was very good. I want to finish up some
other shows before I continue this, but I'll definitely be returning.

I've almost finished **Last Argument of Kings** — the third book in the **The First Law** trilogy.
It's so good and I'm pleased that there's [plenty more to come](https://en.wikipedia.org/wiki/The_First_Law).

I downloaded **No Man's Sky** on Steam. I played it briefly on Xbox many months ago and enjoyed it,
but it recently went on sale and I had to snap it up. Destiny has been slow recently, so I hope
to dig in to this properly soon. From what I've heard, it came be a bit of a time consumer. I am
nothing it not willing to throw time at a sci-fi RPG.

---

Posts I enjoyed:

- [Unfinished Business with Postgres](https://www.craigkerstiens.com/2022/05/18/unfinished-business-with-postgres/)
- [An Interactive Guide to Flexbox](https://www.joshwcomeau.com/css/interactive-guide-to-flexbox/)
