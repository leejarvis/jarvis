%{
  title: "Ruby 3.1 - Pattern Matching",
}
---

As is tradition on Christmas Day, Santa Claus brought us a new version of Ruby. Ruby 3 introduced some new pattern matching syntax that is no longer experimental. This means you can use these new features without fear of them changing dramatically in any (near-future) version of Ruby. Let's take a look.

## Inline matching expressions

There are two types of standalone matching expressions. One using `<expression> => <pattern>` and the other uses `<expression> in <pattern>`:

```ruby
# Assign `first` to "foo" and `last` to "qux". The star (*) represents "rest" as in, the rest of the elements we don't care about
%w(foo bar baz qux) => [first, *, last]

# We can actually assign the "rest" to a variable:
%w(foo bar baz qux) => [first, *rest, last]
rest #=> ["bar", "baz"]

# Raises a NoMatchingPatternError because the lengths differ:
%w(foo bar baz qux) => [first, last]
```

The `in` is similar but returns `true` if a match is found:

```ruby
%w(foo bar baz qux) in [first, *, "qux"]
#=> true
first #=> "foo"

%w(foo bar baz qux) in [first, "qux"]
#=> false
```

We can also include optional classes to match against:

```ruby
%w(foo bar) => [String => first, String => last]
%w(foo bar) in [String, String] #=> true
%w(foo bar) in [String, Integer] #=> false

# Raises a NoMatchingPatternError:
%w(foo bar) => [String => first, Integer => last]
```

We can also match against a Hash pattern:

```ruby
{foo: "bar"} => {foo:}
foo #=> "bar"

{foo: "bar"} => {foo: renamed}
renamed #=> "bar"

{foo:"bar"} in {foo:}
#=> true

{foo:"bar"} in {bar:}
#=> false

# The braces are optional:
{foo:"bar"} => foo:
foo #=> "bar"

# with explicit class matching:
{foo:"bar"} => {foo:String => renamed}
renamed #=> "bar"

# nested values:
{this: {is: {nested: "value"}}} => {this: {is: {nested:}}}
nested #=> "value"
```

One important thing to mention is that Array matches work against the _entire_ Array. Whereas you can match against a Hash subset:

```ruby
{foo: "bar", baz: "qux"} => {baz:} # ignore the :foo key
baz => "qux"
```

We can also mix patterns using the `|` operator. Let's say we want to check if a Hash value is an Integer or a Float:

```ruby
>> {foo: 1.2} in {foo:Integer | Float}
=> true

>> {foo: "bar"} in {foo:Integer | Float}
=> false
```

## Expanding to block expressions

Now we've learned the new syntax, let's extend this by taking advantage of how the pattern matching syntax works with `case` statements.

Let's write up a real program this time. This script lists all GitHub repos for a given username, and then asks the user to enter the name of the repo they want more information about. Let's start by building up to the name selection:

```ruby
#!/usr/bin/env ruby

require "net/http"
require "json"

username = "leejarvis"
endpoint = URI("https://api.github.com/users/#{username}/repos")
json = Net::HTTP.get_response(endpoint).body
repos = JSON.parse(json, symbolize_names: true)

# ignore archived and disabled repos
selectable_repos = repos.select { _1 in archived: false, disabled: false }

puts "Enter a repo name to get more information: "
selectable_repos.each { |repo| puts repo[:name] }

repo_name = gets.strip

selectable_repos.each do |repo|
  case repo
  in name: repo_name
    p repo
  else
    # ignore for now
  end
end
```

As you can see here, we're already taking advantage of the new `in` syntax by ignoring archived and disabled repos. We could write this as `.reject { |repo| repo[:archived] || repo[:disabled] }` but let's not be a party pooper, eh?

Now, when we enter a repo name we'll dump the data for that repo to the console. Here we go:

```ruby
~$ Enter a repo name to get more information:
adventofcode
#=> {:id=>113033185, :name=>"adventofcode", …}
#=> {:id=>1114377, :name=>"albeano", …}
#=> lots more repos

~$ Enter a repo name to get more information:
chronic
#=> {:id=>113033185, :name=>"adventofcode", …}
#=> {:id=>1114377, :name=>"albeano", …}

~$ Enter a repo name to get more information:
zomgroflbbq
#=> {:id=>113033185, :name=>"adventofcode", …}
#=> {:id=>1114377, :name=>"albeano", …}
```

Uh, ok. Looks like this isn't quite working. Every one of our repos is being dumped to the console, it appears to completely ignore our input.

Enter Variable pinning.

## Variable pinning

In our `case` expression above, we're trying to match against our entered `repo_name` — however, as we've seen in previous examples, the match `in name: repo_name` would assign `name` to `repo_name` rather than match against it.

In order to match against our entered value, we need to pin the `repo_name` variable:

```ruby
case repo
in name: ^repo_name
  p repo
else
  # ignore for now
end
```

Now our program works as expected. Let's use our deconstructing syntax to pull some information from the repo:

```ruby
repo => {
  html_url: url,
  default_branch: branch,
  updated_at:,
  watchers_count: Integer => watching
}

puts "Repo #{repo_name} is available at: #{url}. " \
     "The default branch is #{branch} and it was " \
     "last updated on #{updated_at} and has #{watching} watchers"
```

Looking good so far.

We wouldn't want to release our script to the world without a sprinkle of Object Oriented programming though, would we? Let's create a class for our repo and update our list of selectable repos:

```ruby
class Repo
  attr_reader :name, :attributes

  def initialize(attributes)
    @attributes = attributes

    attributes => {
      name: name,
      html_url: url,
      default_branch: branch,
      updated_at: updated_at,
      watchers_count: Integer => watching
    }

    @name, @url, @branch, @updated_at, @watching = name, url, branch, updated_at, watching
  end

  def to_s
    "Repo #{name} is available at: #{@url}. " \
         "The default branch is #{@branch}, it was " \
         "last updated on #{@updated_at} and has #{@watching} watchers"
  end
end

selectable_repos = selectable_repos.map { Repo.new(_1) }

selectable_repos.each do |repo|
  case repo
  in name: ^repo_name
    puts repo
  else
    # ignore for now
  end
end
```

Looking good. Unfortunately pattern matching doesn't work with instance variables (maybe one day?), so we have to assign to locals first in our `initialize` method.

Now when we run our program again it.. well, it doesn't work. This is because our `in name: ^repo_name` code is still expecting `repo` to be a `Hash`.

Thankfully, the Ruby team have thought about this.

## Matching non-primitive objects

So far we've discussed matching against Array and Hash. But how do we match against our new `Repo` objects? Well, we just need to add two new methods: `deconstruct` and `deconstruct_keys`:

```ruby
def deconstruct
  @attributes.keys
end

def deconstruct_keys(keys)
  @attributes.slice(*keys)
end
```

We use `deconstruct` for Array and find patterns, and `deconstruct_keys` for Hash deconstruction. In our `in name: ^repo_name` match, the keys passed to `deconstruct_keys` will be `[:name]` — this allows us to return only the relevant deconstructed values from the attributes hash.

Let's play with this a bit in IRB with information we have about inline matching expressions:

```ruby
>> repo => {name:}
=> nil
>> name
=> "adventofcode"
>> [:name] in repo
=> true
```

Now when we run our program again, everything is working fine. We can also include class names as part of our pattern which would restrict the matching a little (right now we'll match against any object that implements a matching `deconstruct_keys`):

```ruby
case repo
in Repo(name: ^repo_name)
  puts repo
else
  # ignore for now
end
```

## Wrapping up

At first glance, a lot of this syntax just left me squinting. I'm really not sure how I'll feel seeing some of these patterns used in production code because it seems quite easy to abuse.

That said, it's nice to see the Ruby language evolving and I really like the idea of being able to use pattern matching to avoid long conditional statements especially when consuming JSON:

```ruby
data = {
  books: [
    {
      name: "To Kill a Mockingbird",
      meta: {
        tags: [
          { name: "Novel" },
          { name: "Thriller" }
        ]
      }
    },
    {
      name: "The Lord of the Rings",
      meta: {
        tags: [
          { name: "Novel" },
          { name: "Fantasy" }
        ]
      }
    }
  ]
}

fantasy1 = data[:books].select do |book|
  book[:meta] && book[:meta][:tags] && book[:meta][:tags].any? { |tag| tag[:name] == "Fantasy" }
end

fantasy2 = data[:books].select do |book|
  book in { meta: { tags: [*, { name: "Fantasy" }, *] } }
end
```
