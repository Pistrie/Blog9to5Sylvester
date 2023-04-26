defmodule BlogNineToFiveSylvester.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias BlogNineToFiveSylvester.Blog.Comment

  schema "posts" do
    field :author, :string
    field :text, :string
    field :title, :string

    timestamps()

    has_many :comments, Comment
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :text, :author])
    |> validate_required([:title, :text, :author])
    |> validate_length(:author, min: 2)
    |> validate_length(:title, min: 2)
  end
end
