defmodule BlogNineToFiveSylvester.Graphql.Types.Post do
  use Absinthe.Schema.Notation
  alias BlogNineToFiveSylvester.Blog.Comment
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :post_entity do
    field :id, non_null(:id)
    field :author, non_null(:string)
    field :text, non_null(:string)
    field :title, non_null(:string)

    field :comments, list_of(:comment_entity), resolve: dataloader(Comment)
  end
end
