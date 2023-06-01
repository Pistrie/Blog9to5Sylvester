defmodule BlogNineToFiveSylvester.Graphql.Mutations.Comment do
  use Absinthe.Schema.Notation

  alias BlogNineToFiveSylvester.Graphql.Resolvers.Comments

  input_object :create_comment_input do
    field :author, non_null(:string)
    field :text, non_null(:string)
    field :post_id, non_null(:integer)
  end

  object :comment_mutations do
    @desc "Add comment to post"
    field :add_comment_to_post, :comment_entity do
      arg :create_comment, non_null(:create_comment_input)

      resolve(&Comments.add_to_post/3)
    end
  end
end
