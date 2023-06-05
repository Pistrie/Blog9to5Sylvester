defmodule BlogNineToFiveSylvester.Graphql.Resolvers.Comments do
  alias BlogNineToFiveSylvester.Repo
  alias BlogNineToFiveSylvester.Blog.Comment

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

  def add_to_post(_root, %{create_comment: params}, _info) do
    %Comment{}
    |> Comment.changeset(params)
    |> Repo.insert()
    |> do_response()
  end

  defp do_response({:ok, comment}), do: {:ok, comment}
  defp do_response({:error, reason}), do: {:error, reason |> format_changeset_errors()}
end
