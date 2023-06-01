defmodule BlogNineToFiveSylvester.UselessFacts.FactFetchingJob do
  require Logger
  use Oban.Worker

  alias BlogNineToFiveSylvester.UselessFacts.Client

  @impl Oban.Worker
  def perform(%Oban.Job{}), do: Client.fetch_random_fact() |> do_fetch()

  defp do_fetch({:ok, fact}) do
    Logger.info(fact)
    :ok
  end

  defp do_fetch({:error, reason}) do
    error_msg = "Failed to get fact: #{inspect(reason)}"
    Logger.error(error_msg)
    {:error, error_msg}
  end
end
