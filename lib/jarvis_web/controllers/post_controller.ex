defmodule JarvisWeb.PostController do
  use JarvisWeb, :controller

  def index(conn, _params) do
    render(conn, :index, posts: Jarvis.Blog.posts())
  end

  def show(conn, %{"year" => year, "id" => id}) do
    render(conn, :show, post: Jarvis.Blog.get_post_by_year_and_id!(year, id))
  end
end
