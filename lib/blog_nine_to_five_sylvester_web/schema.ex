defmodule BlogNineToFiveSylvesterWeb.Schema do
  use Absinthe.Schema

  alias BlogNineToFiveSylvesterWeb.Resolvers

  object :post do
    field :id, non_null(:id)
    field :author, :string
    field :text, :string
    field :title, :string
  end

  query do
    @desc "Get all posts"
    field :all_posts, non_null(list_of(non_null(:post))) do
      resolve(&Resolvers.Blog.all_posts/3)
    end
  end

  mutation do
    @desc "Create a new post"
    field :create_post, :post do
      arg(:author, non_null(:string))
      arg(:title, non_null(:string))
      arg(:text, non_null(:string))

      resolve(&Resolvers.Blog.create_post/3)
    end
  end
end
