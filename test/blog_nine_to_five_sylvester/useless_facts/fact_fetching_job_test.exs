defmodule BlogNineToFiveSylvester.UselessFacts.FactFetchingJobTest do
  use BlogNineToFiveSylvesterWeb.ConnCase, async: true
  use Oban.Testing, repo: BlogNineToFiveSylvester.Repo

  import Tesla.Mock

  alias BlogNineToFiveSylvester.UselessFacts.FactFetchingJob

  setup do
    mock(fn
      %{method: :get, url: "https://uselessfacts.jsph.pl/api/v2/facts/random?language=en"} ->
        %Tesla.Env{status: 200, body: %{"text" => "some useless fact"}}
    end)

    :ok
  end

  test "queue fact fetching" do
    assert :ok == perform_job(FactFetchingJob, %{})
  end

  test "fact fetching gets queued" do
    perform_job(FactFetchingJob, %{})

    assert_enqueued(worker: FactFetchingJob, args: %{})
  end

  test "fact gets retrieved" do
    assert :ok == perform_job(FactFetchingJob, %{})
  end
end
