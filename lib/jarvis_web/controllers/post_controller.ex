defmodule JarvisWeb.PostController do
  use JarvisWeb, :controller

  @redirects %{
    "gear-2018" => "/uses",
    "gear-2019" => "/uses",
  }

  def index(conn, _params) do
    render(conn, :index, page_title: "Posts", posts: Jarvis.Blog.posts())
  end

  def show(conn, %{"year" => year, "id" => id}) do
    if (redirect_path = @redirects[id]) do
      redirect(conn, to: redirect_path)
    else
      post = Jarvis.Blog.get_post_by_year_and_id!(year, id)
      conn
      |> assign(:page_title, post.title)
      |> render(:show, post: post)
    end
  end

  def feed(conn, _params) do
    conn
    |> put_resp_content_type("text/xml")
    |> send_resp(200, build_feed())
  end

  defp build_feed() do
    alias Atomex.Feed

    posts = Jarvis.Blog.posts()
    last_update = Enum.map(posts, &(&1.published_at)) |> Enum.max()

    Feed.new(url(~p"/"), last_update, "Lee Jarvis")
    |> Feed.author("Lee Jarvis", email: "lee@jrvs.uk")
    |> Feed.link(url(~p"/feed.xml"), rel: "self")
    |> Feed.entries(Enum.map(posts, &feed_entry/1))
    |> Feed.build()
    |> Atomex.generate_document()
  end

  defp feed_entry(post) do
    alias Atomex.Entry

    Entry.new(url(~p"/posts/#{post.year}/#{post.id}"), post.published_at, post.title)
    |> Entry.author("Lee Jarvis", uri: url(~p"/"))
    |> Entry.content({:cdata, post.body}, type: "html")
    |> Entry.build()
  end
end
