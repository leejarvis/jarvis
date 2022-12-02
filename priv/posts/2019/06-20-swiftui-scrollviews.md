%{
  title: "SwiftUI ScrollViews",
  summary: "In which I start playing with SwiftUI.",
}
---

I recently wrote about my [WWDC highlights](/posts/2019/wwdc19), and how
SwiftUI was a huge surprise announcement for me. I decided to have a play and
build something small.

A few years ago I created an iOS app that tracks gift ideas for family and
friends. It's not something I ever published to the app store, but I do
keep it for personal use.

The app isn't particularly exciting. It stores gift ideas and keeps track
of birthdays, anniversaries, etc. On the app homescreen I have a
horizontal scroll view that shows some of my upcoming events; "Mum's birthday",
"My Wedding Anniversary".

These event "cards" were made up of a name and a custom emoji/background colour.
To drastically simplify, they looked something like this (but better, I promise):

![](/images/posts/swiftui-scrollview.png)

The ScrollView wasn't especially difficult to build, but asking AutoLayout to
play nicely across all devices in any orientation wasn't exactly my idea of fun.
Not only was it tedious and time-consuming, it was really sucking
the fun out of creating the app.

With SwiftUI, I was able to re-create a similar ScrollView with just several
lines of code:

```swift
import SwiftUI

struct Event: Identifiable {
    let id: Int
    let name: String
    let emoji: String
    let color: Color
}

let events = [
    Event(id: 0, name: "Jon's Birthday", emoji: "🥳", color: Color.red),
    Event(id: 1, name: "Wedding", emoji: "👰", color: Color.blue),
    Event(id: 2, name: "Aimee's Birthday", emoji: "🎉", color: Color.green),
    Event(id: 3, name: "Christmas", emoji: "🎄", color: Color.purple),
]

struct ContentView : View {
    var body: some View {
        ScrollView(.horitonzal) {
            HStack {
                ForEach(events) { event in
                    VStack {
                        Text(event.emoji)
                            .font(.system(size: 50))
                        Text(event.name)
                            .font(.system(.caption))
                    }
                    .padding(40)
                    .background(event.color)
                    .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}
```

This is the entire file. Go ahead, paste it into Xcode 11 beta.

No AutoLayout constraints, no Storyboards, no testing across every device
just to be sure I didn't break something. The UI exists right here in
the code.

The declarative syntax really makes the code easy to read and write, and
using Xcode's powerful built-in documentation and suggestion tools,
I found myself creating the user-interface is a very natural way.

This was built on macOS Mojave, which doesn't have access to the live
preview canvas and drag+drop behaviour. This meant I had to rebuild the
app each time to preview my changes. No bother, I've been doing that
for years. I can only imagine how much better this is on macOS Catalina.

I've been watching some of the WWDC session videos too. Here's some good
ones on SwiftUI:

* [Introducing SwiftUI: Building Your First App](https://developer.apple.com/videos/play/wwdc2019/204/)
* [SwiftUI Essentials](https://developer.apple.com/videos/play/wwdc2019/216/)
* [Accessibility in SwiftUI](https://developer.apple.com/videos/play/wwdc2019/238/)

All WWDC videos can be [found here](https://developer.apple.com/videos/all-videos/).

I'll be continuing to play with SwiftUI and may write a post or two in
the coming weeks. I am incredibly excited for this technology; it makes
building mobile applications much more accessible. Finally, for me, iOS
development is fun again.

Update: I've expanded the app to introduce state and bindings. You can
read about it [here](/posts/2019/swiftui-bindings).
