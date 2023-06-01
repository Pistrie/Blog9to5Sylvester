defmodule BlogNineToFiveSylvester.UselessFacts.JobsTest do
  use BlogNineToFiveSylvesterWeb.ConnCase
  use Oban.Testing, repo: BlogNineToFiveSylvester.Repo

  setup do
    Tesla.Mock.mock(fn
      %{method: :get, url: "https://uselessfacts.jsph.pl/api/v2/facts/random?language=en"} ->
        %Tesla.Env{status: 200, body: %{"text" => "some useless fact"}}
    end)

    :ok
  end

  test "queue fact fetching" do
    assert :ok == perform_job(BlogNineToFiveSylvester.UselessFacts.FactFetchingJob, %{})
  end

  test "fact fetching gets queued" do
    BlogNineToFiveSylvester.UselessFacts.FactFetchingJob.new(%{})
    |> Oban.insert!()

    assert_enqueued(worker: BlogNineToFiveSylvester.UselessFacts.FactFetchingJob, args: %{})
  end

  test "fact gets retrieved" do
    assert :ok == perform_job(BlogNineToFiveSylvester.UselessFacts.FactFetchingJob, %{})
  end
end
