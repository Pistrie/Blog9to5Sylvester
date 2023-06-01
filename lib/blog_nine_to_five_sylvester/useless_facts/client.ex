defmodule BlogNineToFiveSylvester.UselessFacts.Client do
  use Tesla, only: [:get]

  plug Tesla.Middleware.BaseUrl, "https://uselessfacts.jsph.pl/api/v2/"
  plug Tesla.Middleware.JSON

  def fetch_random_fact do
    "/facts/random"
    |> fact_in_english()
    |> get()
    |> do_get()
  end

  defp fact_in_english(url), do: url <> "?language=en"

  defp do_get({:ok, %{body: %{"text" => text}}}), do: {:ok, text}
  defp do_get({:error, reason}), do: {:error, reason}
end
