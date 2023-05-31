defmodule BlogNineToFiveSylvester.UselessFacts.JobsTest do
  use BlogNineToFiveSylvesterWeb.ConnCase
  use Oban.Testing, repo: BlogNineToFiveSylvester.Repo

  test "queue fact fetching" do
    :ok = perform_job(BlogNineToFiveSylvester.UselessFacts.FactFetchingJob, %{})
  end

  test "fact fetching gets queued" do
    # FIXME how to test whether job is queued
    BlogNineToFiveSylvester.UselessFacts.FactFetchingJob.new(%{})
    |> Oban.insert!()

    # assert_enqueued(worker: BlogNineToFiveSylvester.UselessFacts.FactFetchingJob, args: %{})
  end

  test "fact gets retrieved" do
    assert :ok == perform_job(BlogNineToFiveSylvester.UselessFacts.FactFetchingJob, %{})
  end
end
