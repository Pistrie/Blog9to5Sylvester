defmodule BlogNineToFiveSylvester.Graphql.Queries.Post do
  use Absinthe.Schema.Notation
  alias BlogNineToFiveSylvester.Graphql.Resolvers.Posts

  object :post_queries do
    @desc "Get all posts"
    field :all_posts, non_null(list_of(non_null(:post_entity))) do
      resolve(&Posts.list/3)
    end

    @desc "Get post by ID"
    field :post_by_id, :post_entity do
      arg(:id, non_null(:id))
      resolve(&Posts.get/3)
    end
  end
end
