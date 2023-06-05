defmodule BlogNineToFiveSylvester.Blog.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias BlogNineToFiveSylvester.Blog.Post

  schema "comments" do
    field :author, :string
    field :text, :string
    belongs_to :post, Post

    timestamps()
  end

  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text, :author, :post_id])
    |> validate_required([:text, :author, :post_id])
    |> validate_length(:author, min: 2)
  end
end
