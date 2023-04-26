defmodule BlogNineToFiveSylvesterWeb.Resolvers.Blog do
  alias BlogNineToFiveSylvester.Blog

  def all_posts(_root, _args, _info) do
    {:ok, Blog.list_posts()}
  end

  def get_post_by_id(_root, args, _info) do
    {:ok, Blog.get_post!(args.id)}
  end

  def create_post(_root, args, _info) do
    case Blog.create_post(args) do
      {:ok, post} -> {:ok, post}
      {:error, reason} -> {:error, reason}
    end
  end

  def load_comments(root, _args, _info) do
    {:ok, Blog.list_comments_by_post(root)}
  end

  def add_comment_to_post(_root, args, _info) do
    case Blog.create_comment(args) do
      {:ok, comment} -> {:ok, comment}
      {:error, reason} -> {:error, reason}
    end
  end
end
