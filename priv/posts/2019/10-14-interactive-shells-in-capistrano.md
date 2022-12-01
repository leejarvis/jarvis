%{
  title: "Interactive Shells in Capistrano",
  summary: "How to start a remote Rails console (and other interactive commands) via Capistrano",
}
---

[Capistrano](https://capistranorb.com) is a very popular deployment tool written in Ruby.
If you've deployed Ruby or Rails applications, chances are you've heard of it even if
you haven't had the chance to use it.

Capistrano was a crucial part of our deployment process at [Loco2](https://loco2.com) long before
[overhauling our hosting infrastructure](https://www.jonathanleighton.com/articles/2016/loco2-infrastructure-overhaul/)
with Terraform and Docker.

Having [recently left Loco2](/posts/2019/leaving-loco2), I found myself back on a
project that uses Capistrano. As powerful as it is, it frustratingly doesn't
include support for interactive shells. Whilst this is [by design](https://capistranorb.com/documentation/advanced-features/ptys/),
it's a bit annoying if you want to boot a rails console or run another command
that allows input from the user.

After doing some Googling I managed to piece together something that calls `ssh`
directly, allowing us to run a command in an interactive shell:

```ruby
namespace :rails do
  desc "Start a rails console"
  task :console do
    exec_interactive("rails console")
  end

  desc "Start a rails dbconsole"
  task :dbconsole do
    exec_interactive("rails dbconsole")
  end

  def exec_interactive(command)
    host = primary(:web).hostname
    env = "RAILS_ENV=#{fetch(:rails_env)}" # add other ENV variables
    command = "cd #{release_path}; #{env} bundle exec #{command}"

    puts "Running command on #{host}:"
    puts "  #{command}\n\n"

    exec %(ssh #{host} -t "sh -c '#{command}'")
  end
end
```

The `primary(:web).hostname` just fetches the hostname for the first/primary web
host. It's worth mentioning this because it _might_ not be desirable. You could
quite easily fetch all of the remote hosts and provide a menu that allows the
user to select the host they want to connect to. For my purposes though, I just
wanted to run a rails console without having a custom script that fetched
our hostname via the AWS command line tools.

You may want to consider safeguarding production access by adding a warning
message when `fetch(:rails_env) == "production"`, or perhaps add
the `--sandbox` option to protect your data.

I believe developers should be trusted to have direct access to all live
environments, including production. These sorts of small convenience scripts
really help to avoid friction when troubleshooting or debugging data issues on
non-local environments.
