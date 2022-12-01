%{
  title: "Dark Mode",
}
---

At the request of my eyeballs, you can now switch to a dark version of the website.

Where available, I tend to use Safari's [Reader Mode](https://www.nytimes.com/2018/07/03/technology/personaltech/safari-reader-mode.html) for reading online content. It has tools to change the
size and colour of the text and background. Sadly even some of the more popular news and
blog websites are often unreadable due to their fancy font styles
and tiny text size.

Reader Mode allows me to quickly switch between light and dark themes, a godsend when
procrastinating late at night.

You'll notice a new lightening-bolt icon in the website header. Zap that (see what I did
there) and you'll switch between dark and light themes.

Adding the code for this was pretty straightforward. The toggle has an `onClick` handler:

```ruby
<a title="Switch theme" onclick="toggleTheme(); return false">
```

with a sprinkle of JavaScript in `<head>`:

```javascript
function toggleTheme() {
    if (localStorage.getItem("theme") === null) {
        localStorage.setItem("theme", "dark")
        document.querySelector("body").classList.add("dark")
    } else {
        localStorage.removeItem("theme")
        document.querySelector("body").classList.remove("dark")
    }
}

document.addEventListener("DOMContentLoaded", function(e) {
    if (localStorage.getItem("theme") === "dark") {
        document.querySelector("body").classList.add("dark")
    } else {
        document.querySelector("body").classList.remove("dark")
    }
})
```

Using [localStorage](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage) allows
the theme setting to persist across page views and browser sessions.

If you're observant you might notice the small flash of unstyled content when using
the dark theme, since it waits for the DOM to load before applying the style.
I consider this a fair trade-off to keep things simple.

Now all that's left to do is update the existing styles when the darker theme is
in use:

```css
body.dark {
    /* dark style overrides here */
}
```

I'm using [SCSS](https://sass-lang.com/documentation/syntax), so I could just as
easily use a mixin for applying dark styles inline.

In addition to this, [Safari is introducing a new media query](https://css-tricks.com/dark-modes-with-css/)
called `prefers-color-scheme`, allowing us to automatically apply these themes
when a visitor is using dark mode on macOS.

You're welcome, eyeballs.
