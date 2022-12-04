defmodule Jarvis.Blog.Post do
  @enforce_keys [:id, :title, :body, :year, :published_at]
  defstruct [:id, :title, :body, :summary, :year, :published_at]

  def build(filename, attrs, body) do
    attrs =
      parse_dates_and_id(filename)
      ++ [body: body]
      ++ Map.to_list(attrs)

    struct!(__MODULE__, attrs)
  end

  defp parse_dates_and_id(filename) do
    [year, id] =
      filename
      |> Path.rootname()
      |> Path.split()
      |> Enum.take(-2)

    [month, day, id] = String.split(id, "-", parts: 3)
    published_at = parse_datetime("#{year}-#{month}-#{day} 09:00:00+00")

    [published_at: published_at, year: year, id: id]
  end

  defp parse_datetime(datetime) do
    {:ok, dt, 0} = DateTime.from_iso8601(datetime)
    dt
  end
end
