defmodule JarvisWeb.PostController do
  use JarvisWeb, :controller

  @redirects %{
    "gear-2018" => "/uses",
    "gear-2019" => "/uses",
  }

  def index(conn, _params) do
    render(conn, :index, posts: Jarvis.Blog.posts())
  end

  def show(conn, %{"year" => year, "id" => id}) do
    if (redirect_path = @redirects[id]) do
      redirect(conn, to: redirect_path)
    else
      render(conn, :show, post: Jarvis.Blog.get_post_by_year_and_id!(year, id))
    end
  end
end
