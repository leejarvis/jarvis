defmodule Jarvis.Blog do
  use NimblePublisher,
    build: Jarvis.Blog.Post,
    from: Application.app_dir(:jarvis, "priv/posts/**/*.md"),
    as: :posts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  defmodule NotFoundError, do: defexception [:message, plug_status: 404]

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  def posts, do: @posts
  def recent_posts, do: Enum.take(posts(), 3)

  def get_post_by_year_and_id!(year, id) do
    Enum.find(posts(), &(&1.year == year && &1.id == id)) ||
      raise NotFoundError, "post with id=#{id} not found"
  end
end
