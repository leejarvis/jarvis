defmodule JarvisWeb.PageControllerTest do
  use JarvisWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Lee Jarvis"
  end

  test "GET /about", %{conn: conn} do
    conn = get(conn, ~p"/about")
    assert html_response(conn, 200) =~ "I'm Lee"
  end

  test "GET /uses", %{conn: conn} do
    conn = get(conn, ~p"/uses")
    assert html_response(conn, 200) =~ "What I use"
  end
end
