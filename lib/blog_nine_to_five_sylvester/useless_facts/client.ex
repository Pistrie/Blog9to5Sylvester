defmodule BlogNineToFiveSylvester.UselessFacts.Client do
  use Tesla, only: [:get]

  plug Tesla.Middleware.BaseUrl, "https://uselessfacts.jsph.pl/api/v2/"
  plug Tesla.Middleware.JSON

  def fetch_random_fact do
    "/facts/random"
    |> fact_in_english()
    |> get()
    |> extract_fact_field()
  end

  defp fact_in_english(url) do
    url <> "?language=en"
  end

  defp extract_fact_field(http_response) do
    {:ok, %{body: %{"text" => text}}} = http_response
    text
  end
end
