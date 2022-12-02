%{
  title: "My Backup Strategy",
  summary: "Preparing for the apocalypse.. and terrible computers",
}
---

Preaching the importance of backing up your data in 2019 might seem like
flogging a dead horse. With the rise of cloud storage and local backup
solutions, it's almost impossible _not_ to have a back up of some sort.

It can't have been more than 5 years ago that my local library were
dishing out free leaflets featuring bewildered old folk staring at computer
screens. The caption **Are you backing up?** written in classic clip art text
and complemented by none other than a giant floppy disk. Backing up isn't
just for the geeks and the paranoid.

And still, in 2019, this advice remains critical for anyone storing digital
copies of their files. With the increase in paperless forms and bills,
one might even argue that it's more important now than ever before.
We should all ask ourselves what would happen to the documents we care about
if our devices were to be stolen or damaged. Would we lose them forever? Does
it even really matter?

Nowadays these backup and syncing solutions are simple enough that asking these
questions is an exercise in futility. And rightfully so, backing up your data
should be a matter of course, an inevitability. Any good backup strategy should:

1. Be simple and easy to manage. It shouldn't require a load of work.
1. Be redundant. You need multiple copies, not just one, especially if it's
   in the same location as the master.
1. Be easily testable. You should be able to restore from backups without
   hassle, and you should test that everything is working every so often.

### Easy as 1, 2, 3, (4)

I follow the
[3-2-1 backup strategy](https://www.backblaze.com/blog/the-3-2-1-backup-strategy/),
which means I have at least 3 total copies of my data. I actually
have 4 just for the hell of it:

1. Master copy on my computer hard-drive
1. Second copy on my Time Machine backup
1. Third copy on Carbon Copy Cloner
1. Fourth offsite copy on Backblaze

![](/images/posts/backup-diagram.png)

The Backblaze article above compares backing up your data to diversifying
your investment portfolio. There's no perfect solution, but lowering your
risk is a prudent way to reduce the chance of losing data.

I have Time Machine pointed at a 500GB WD external hard drive for each
computer and it just ticks along nicely in the background. With external
hard drive prices continuing to bomb, you really don't have to break
the bank to get this solution up-and-running. If I was buying a new external
drive now, I'd probably pick the [Samsung T5 Portable SSD](https://www.amazon.co.uk/dp/B074M774TW/ref=cm_sw_em_r_mt_dp_U_NyfkDbZTV7355).

[Carbon Copy Cloner](https://bombich.com/) is used to create a bootable
backup drive, allowing me to simply plug-in and get going again at a moments
notice. I've heard good things about
[SuperDuper](https://www.shirt-pocket.com/SuperDuper/SuperDuperDescription.html)
but haven't yet felt inclined to switch away from CCC, even if it's a little
hard on the eyes.

Finally, I have [Backblaze](https://www.backblaze.com) running on all of my
machines. It's one of the first things I install, and at $6/month, it's a
steal. You can even let Backblaze back up your external drives at no extra cost.
If you need a single file, you can cherry-pick them from the web UI or
download a full backup in the event of a catastrophe. If you have a _lot_
of data, Backblaze will mail you a hard-drive full of your data so you don't
have to re-download everything.

All of this might seem somewhat excessive, but having had my fair share of
hardware failures, I can tell you that I learned a hard lesson from not backing
up earlier. Don't wait for a disaster before you have a backup plan.

PS:
[cloud sync is a not a backup](https://www.backblaze.com/blog/sync-vs-backup-vs-storage/).
