defmodule BlogNineToFiveSylvesterWeb.Resolvers.Blog do
  alias BlogNineToFiveSylvester.Blog

  def all_posts(_root, _args, _info) do
    {:ok, Blog.list_posts()}
  end

  def create_post(_root, args, _info) do
    case Blog.create_post(args) do
      {:ok, post} -> {:ok, post}
      {:error, reason} -> {:error, reason}
    end
  end
end
