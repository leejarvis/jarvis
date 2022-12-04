defmodule JarvisWeb.PostControllerTest do
  use JarvisWeb.ConnCase

  test "GET /posts", %{conn: conn} do
    [post | _] = Jarvis.Blog.posts()
    conn = get(conn, ~p"/posts")

    assert html_response(conn, 200) =~ post.title
  end

  test "GET /feed.xml", %{conn: conn} do
    conn = get(conn, ~p"/feed.xml")
    {:ok, doc} = Floki.parse_document(conn.resp_body)

    assert "Lee Jarvis" == Floki.find(doc, "feed > author > name") |> Floki.text()
    assert "lee@jarvis.to" == Floki.find(doc, "feed > author > email") |> Floki.text()

    [{"entry", [], entry} | _] = Floki.find(doc, "feed > entry")
    [post | _] = Jarvis.Blog.posts()

    assert post.title == Floki.find(entry, "title") |> Floki.text()
  end
end
