defmodule JarvisWeb.PageController do
  use JarvisWeb, :controller

  def home(conn, _params) do
    render(conn, :home, recent_posts: Jarvis.Blog.recent_posts())
  end

  def about(conn, _params) do
    render(conn, :about, page_title: "About")
  end

  def uses(conn, _params) do
    render(conn, :uses, page_title: "Uses")
  end

  def contact(conn, _params) do
    render(conn, :contact, page_title: "Contact")
  end
end
