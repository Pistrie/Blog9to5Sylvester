defmodule BlogNineToFiveSylvester.Graphql.Mutations.Post do
  use Absinthe.Schema.Notation

  alias BlogNineToFiveSylvester.Graphql.Resolvers.Posts

  input_object :create_post_input do
    field :author, non_null(:string)
    field :title, non_null(:string)
    field :text, non_null(:string)
  end

  object :post_mutations do
    @desc "Create a new post"
    field :create_post, :post_entity do
      arg :create_post, non_null(:create_post_input)

      resolve(&Posts.create/3)
    end
  end
end
