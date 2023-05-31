defmodule BlogNineToFiveSylvester.UselessFacts.FactFetchingJob do
  require Logger
  use Oban.Worker

  alias BlogNineToFiveSylvester.UselessFacts.Client

  @impl Oban.Worker
  def perform(%Oban.Job{}) do
    case Client.fetch_random_fact() do
      {:ok, fact} ->
        Logger.info(fact)
        :ok

      {:error, error} ->
        error_msg = "Failed to get fact: #{inspect(error)}"
        Logger.error(error_msg)
        {:error, error_msg}
    end
  end
end
