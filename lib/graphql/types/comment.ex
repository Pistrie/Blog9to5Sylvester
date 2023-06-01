defmodule BlogNineToFiveSylvester.Graphql.Types.Comment do
  use Absinthe.Schema.Notation

  object :comment_entity do
    field :id, non_null(:id)
    field :author, non_null(:string)
    field :text, non_null(:string)
    field :post_id, non_null(:id)
  end
end
