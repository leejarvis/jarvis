%{
  title: "Weeknotes 2: maple poutine",
}
---

I am — [once again](https://leejarvis.me/posts/2022/weeknotes-1-oops-i-did-it-again) — writing these notes at around 38,000 feet. This time somewhere above the snowy mountains of Saskatchewan.

I have spent the last seven days visiting my work mates in Vancouver. I've had a blast, and whilst I could probably do another week, I'm looking forward to getting home to the family.

Besides work, my visit was largely spent eating good food and drinking good booze. All in very good company. It almost felt a challenge to find a type of cuisine that I do not enjoy (spoiler: the search continues).

Here's a few nice places I ate: [Gotham Steakhouse](https://gothamsteakhouse.com), [MeeT](https://eatmeet.ca), [Babylon](https://babyloncafe.ca), [Pigot's](https://pigotsburgerclub.com), [Zarak](https://www.zarakvancouver.com), [Merci Beaucoup](https://www.mercibeaucoupcafe.com). If I had to recommend only one, it'd be Zarak. The Afghan food is incredible.

Didn't do much walking besides the usual [Stanley Park sea wall](https://vancouver.ca/parks-recreation-culture/stanley-park.aspx). That had to be the only day I didn't return to the hotel smelling of weed.

Canada — or at least Vancouver specifically — are dealing with the pandemic very differently from us in the U.K. I couldn't eat or drink in a restaurant or cafe without showing proof of vaccination. And people actually wear masks. Like, everywhere.

---

The week was productive. I've been working pretty relentlessly since before the Christmas break though, and would have preferred a more relaxed week. Sometimes I felt like I pretty much had my head down all day, not really being able to make the most of being in-person. Though I probably more than made up for it during the evenings.

I merged and deployed our first [ViewComponent](https://viewcomponent.org/), and had some good talks about ways we can utilise this system in future, including a more component focused system that extends in to the design team.

---

I learned about the ActiveRecord [`missing`](https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods/WhereChain.html#method-i-missing) method, which uses an outer left join that returns a relation with missing associations. <br>So `User.joins(:project).where(projects: { id: nil })` becomes `User.missing(:project)` -- this is especially nice when you want to combine an `or` on the join table and bump in to the `Relation passed to #or must be structurally compatible` issue.

I started writing a Rust command line tool that generates (potentially very large) fake CSV files to use as imports in to our CRM. We already have this in Ruby but it's very slow and I wanted to keep the Rust momentum. I'm wrapping my head around some of the more complex syntax but there's still plenty of frowning involved. It's going well otherwise and I suspect I'll keep poking at it as and when I have time.

---

Media corner: I watched and enjoyed [Moneyball](https://letterboxd.com/film/moneyball/) and [Richard Jewell](https://letterboxd.com/film/richard-jewell/), and continued reading [Billy Summers](https://app.thestorygraph.com/books/0248b0fc-6762-4df8-b7a1-7ba45703e92f). Note the new link to [The StoryGraph](thestorygraph.com). Thanks to [Kaitlyn](https://krtierney.com) (the only person who reads these posts) for that.

I was shocked to learn that Microsoft Gaming had acquired Activision Blizzard. I know they've had a lot of HR issues recently, but Microsoft? Talk about antitrust, anticompetitive monopolies. I'm a fan of the Xbox ecosystem, but this doesn't feel like a good long-term deal for gamers.

---

As I write this on the way home, I realise I return to a bunch of tedious life admin. Dentist and optician appointments, deep-cleaning and runs to the waste centre. Such is life.
