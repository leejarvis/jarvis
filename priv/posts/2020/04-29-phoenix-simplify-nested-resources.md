%{
  title: "Phoenix: Using Plugs to improve scoped resources",
  summary: "Improving scoped resources with plugs and pipelines.",
}
---

In this post I'm going to talk about creating a [Phoenix](https://www.phoenixframework.org) web app. The application intends to create a scoped route with nested resources. If you don't know what any of that means then this post _probably_ isn't for you.

### The Goal

I want to create an application that supports a number of resources under a `project` scoping. I want every project to support the following:

1. Users
2. Posts + Comments
3. Events

Since all of these resources belong to the project scope, we need to create a sensible URL structure. Something like this should suffice:

```elixir
/projects/{project_id}/users
/projects/{project_id}/users/{user_id}
/projects/{project_id}/posts
/projects/{project_id}/posts/{post_id}/comments
/projects/{project_id}/events
/projects/{project_id}/events/{event_id}
```

I've omitted some routes, but hopefully you get the point. Let's jump in.

### Scoped Routes

Firstly we need to update our router to support our project scoping. Fortunately Phoenix supports [Scoped Routes](https://hexdocs.pm/phoenix/routing.html#scoped-routes) out of the box, so a straightforward change to our router will add this for us:

```elixir
scope "/projects/:project_id" do
  get "/", ProjectController, :show

  # resources here
end
```

Now if we run `mix phx.routes` we'll see our project scoping:

```
project_path  GET  /projects/:project_id  AppWeb.ProjectController :show
```

### Nested Resources

Next we'll need to add the resources inside of our scoping to complete our URL structure:

```elixir
scope "/projects/:project_id" do
  get "/", ProjectController, :show

  resources "/users", UserController
  resources "/events", EventController
  resources "/posts", PostController do
    resources "/comments", CommentController
  end
end
```

And `mix phx.routes`:

```
     project_path  GET     /projects/:project_id                                   AppWeb.ProjectController :show
        user_path  GET     /projects/:project_id/users                             AppWeb.UserController :index
        user_path  GET     /projects/:project_id/users/:id/edit                    AppWeb.UserController :edit
        user_path  GET     /projects/:project_id/users/new                         AppWeb.UserController :new
        user_path  GET     /projects/:project_id/users/:id                         AppWeb.UserController :show
        user_path  POST    /projects/:project_id/users                             AppWeb.UserController :create
        user_path  PATCH   /projects/:project_id/users/:id                         AppWeb.UserController :update
                   PUT     /projects/:project_id/users/:id                         AppWeb.UserController :update
        user_path  DELETE  /projects/:project_id/users/:id                         AppWeb.UserController :delete
       event_path  GET     /projects/:project_id/events                            AppWeb.EventController :index
       event_path  GET     /projects/:project_id/events/:id/edit                   AppWeb.EventController :edit
       event_path  GET     /projects/:project_id/events/new                        AppWeb.EventController :new
       event_path  GET     /projects/:project_id/events/:id                        AppWeb.EventController :show
       event_path  POST    /projects/:project_id/events                            AppWeb.EventController :create
       event_path  PATCH   /projects/:project_id/events/:id                        AppWeb.EventController :update
                   PUT     /projects/:project_id/events/:id                        AppWeb.EventController :update
       event_path  DELETE  /projects/:project_id/events/:id                        AppWeb.EventController :delete
        post_path  GET     /projects/:project_id/posts                             AppWeb.PostController :index
        post_path  GET     /projects/:project_id/posts/:id/edit                    AppWeb.PostController :edit
        post_path  GET     /projects/:project_id/posts/new                         AppWeb.PostController :new
        post_path  GET     /projects/:project_id/posts/:id                         AppWeb.PostController :show
        post_path  POST    /projects/:project_id/posts                             AppWeb.PostController :create
        post_path  PATCH   /projects/:project_id/posts/:id                         AppWeb.PostController :update
                   PUT     /projects/:project_id/posts/:id                         AppWeb.PostController :update
        post_path  DELETE  /projects/:project_id/posts/:id                         AppWeb.PostController :delete
post_comment_path  GET     /projects/:project_id/posts/:post_id/comments           AppWeb.CommentController :index
post_comment_path  GET     /projects/:project_id/posts/:post_id/comments/:id/edit  AppWeb.CommentController :edit
post_comment_path  GET     /projects/:project_id/posts/:post_id/comments/new       AppWeb.CommentController :new
post_comment_path  GET     /projects/:project_id/posts/:post_id/comments/:id       AppWeb.CommentController :show
post_comment_path  POST    /projects/:project_id/posts/:post_id/comments           AppWeb.CommentController :create
post_comment_path  PATCH   /projects/:project_id/posts/:post_id/comments/:id       AppWeb.CommentController :update
                   PUT     /projects/:project_id/posts/:post_id/comments/:id       AppWeb.CommentController :update
post_comment_path  DELETE  /projects/:project_id/posts/:post_id/comments/:id       AppWeb.CommentController :delete
```

Excellent, this is exactly what we want. Let's take a peek at our comments controller:

```elixir
defmodule AppWeb.CommentController do
  use AppWeb, :controller

  def index(conn, %{"project_id" => project_id, "post_id" => post_id}) do
    render(conn, "index.html", comments: list_comments(project_id, post_id))
  end

  def show(conn, %{"project_id" => project_id, "post_id" => post_id, "id" => comment_id}) do
    render(conn, "show.html", comment: get_comment!(project_id, post_id, comment_id))
  end
end
```

OK, it's not _bad_, but one thing is very clear: every one of our controller actions are going to need to handle this `project_id` parameter.

I come from a Rails background, and the canonical way to solve this in Rails is to add a `before_action`:

```ruby
class CommentController
  before_action :set_project

  # actions

  def set_project
    @project = Project.find(params[:project_id])
  end
end
```

We can't do this in Phoenix.

### Enter Plug

However, Phoenix supports [Plug](https://hexdocs.pm/plug/readme.html). Plug is an Elixir library that implements a specification for composable modules to be used in web applications. Phoenix uses Plug heavily under the hood (in fact, Phoenix controllers themselves implement the Plug behaviour).

Our Phoenix controllers expose a helpful function named `plug` that allows us to implement behaviour similar to our `before_action`:

```elixir
defmodule AppWeb.CommentController do
  use AppWeb, :controller

  plug :put_project

  def show(conn, %{"post_id" => post_id, "id" => comment_id}) do
    %{current_project: project} = conn.assigns
    render(conn, "show.html", comment: get_comment!(project, post_id, comment_id))
  end

  defp put_project(conn, _opts) do
    current_project = fetch_current_project(conn.params["project_id"])
    assign(conn, :current_project, current_project)
  end
end
```

This code is pretty straightforward. `put_project/2` is called before our action is executed, and we put the current project into `conn.assigns` (a storage mechanism provided to us by Plug). Now we can use this function in all of our project-scoped controllers to remove the `%{"project_id" => project_id}` matches.

This is nice, but we can go one step further and move this functionality into our router using pipelines.

### Pipelines

Phoenix supports something called [Pipelines](https://hexdocs.pm/phoenix/routing.html#pipelines). Pipelines allow us to attach a series of plugs to a scope. Let's add a new pipeline for our project scoping:

```elixir
pipeline :project do
  # plug :authenticate_user
  plug AppWeb.CurrentProject
end

scope "/projects/:project_id" do
  pipe_through :project

  get "/", ProjectController, :show

  # ...
end
```

And define `AppWeb.CurrentProject` like so:

```elixir
defmodule AppWeb.CurrentProject do
  @moduledoc """
  This module implements functionality to fetch the current project
  from the URL and add it to Conn.assigns, making it available to any
  controller within the project scope.
  """

  @behaviour Plug

  import Plug.Conn
  import Phoenix.Controller

  @assigns_key :current_project

  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"project_id" => id}} = conn, _opts) do
    assign(conn, @assigns_key, get_project!(id))
  end

  defp get_project!(id) do
    # fetch project from database
  end
end
```

There we have it. All of our project-scoped controllers will be able to fetch the current project from `conn.assigns` without having to add any controller-specific code.

### Bonus: Nested Layouts

By default, Phoenix wraps all of our views in the layout defined in `templates/layout/app.html.eex`. This layout template contains an assign named `@inner_content` which, as you'd expect, returns the content of our view templates.

I want users to see a familiar project-based UI in all of our scoped pages. I don't want to have to create a new app layout because it's going to contain a lot of duplicate code. Similarly, I don't want to have to add a bunch of conditional statements inside of `app.html.eex` that add content based on whether we're inside the project-scoping.

What I really want is a nested layout: `app.html.eex > project.html.eex > our view template`.

Thankfully Phoenix has our backs on this and provides [`Phoenix.Controller.put_root_layout/2`](https://hexdocs.pm/phoenix/Phoenix.Controller.html#put_root_layout/2)

Let's tweak our `AppWeb.CurrentProject` plug:

```elixir
def call(%Plug.Conn{params: %{"project_id" => id}} = conn, _opts) do
  conn
  |> put_layout({AppWeb.ProjectView, "layout.html"})
  |> put_root_layout({AppWeb.LayoutView, "app.html"})
  |> assign(@assigns_key, get_project!(id))
end

defp get_project!(id)
  # fetch project from database
end
```

And create a new file in `templates/project/layout.html.eex` with the following content:

```erb
<h1><%= @current_project.name %></h1>
<div class="project-content">
  <%= @inner_content %>
</div>
```

And that's it. All of our project-scopes view templates will be rendered inside of this layout.

---

Have any suggestions for improving this post? [Let me know](https://twitter.com/lee_jarvis).
