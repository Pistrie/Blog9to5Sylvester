defmodule BlogNineToFiveSylvester.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BlogNineToFiveSylvester.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        author: "some author",
        text: "some text",
        title: "some title"
      })
      |> BlogNineToFiveSylvester.Blog.create_post()

    post
  end

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        post_id: post_fixture().id,
        author: "some author",
        text: "some text"
      })
      |> BlogNineToFiveSylvester.Blog.create_comment()

    comment
  end
end
