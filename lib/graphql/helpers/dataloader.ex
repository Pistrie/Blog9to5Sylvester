defmodule BlogNineToFiveSylvester.GraphQL.Helpers.Dataloader do
  def data, do: Dataloader.Ecto.new(BlogNineToFiveSylvester.Repo, query: &query/2)

  def query(queryable, _params), do: queryable
end
