defmodule Jarvis.Blog.Post do
  @enforce_keys [:id, :title, :body, :year, :date]
  defstruct [:id, :title, :body, :summary, :year, :date, :formatted_date]

  def build(filename, attrs, body) do
    [year, month_day_id] = filename |> Path.rootname() |> Path.split() |> Enum.take(-2)
    [month, day, id] = String.split(month_day_id, "-", parts: 3)
    date = Date.from_iso8601!("#{year}-#{month}-#{day}")
    formatted_date = Calendar.strftime(date, "%B %d, %Y")
    struct!(__MODULE__, [id: id, year: year, date: date, formatted_date: formatted_date, body: body] ++ Map.to_list(attrs))
  end
end
