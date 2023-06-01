defmodule BlogNineToFiveSylvester.Graphql.Resolvers.Posts do
  alias BlogNineToFiveSylvester.Repo
  alias BlogNineToFiveSylvester.Blog.Post

  defp format_changeset_errors(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
    |> Enum.reduce("", fn {key, value}, acc ->
      joined_errors = Enum.join(value, "; ")
      "#{acc}#{key}: #{joined_errors}. "
    end)
    |> String.trim()
  end

  def list(_root, _args, _info), do: {:ok, Repo.all(Post)}

  def get(_root, args, _info) do
    {:ok, Repo.get!(Post, args.id)}
  end

  def create(_root, %{create_post: params}, _info) do
    %Post{}
    |> Post.changeset(params)
    |> Repo.insert()
    |> do_response()
  end

  def do_response({:ok, post}), do: {:ok, post}
  def do_response({:error, reason}), do: {:error, reason |> format_changeset_errors()}
end
