defmodule JarvisWeb.PageController do
  use JarvisWeb, :controller

  def home(conn, _params) do
    render(conn, :home, recent_posts: Jarvis.Blog.recent_posts())
  end

  def about(conn, _params) do
    render(conn, :about)
  end
end
