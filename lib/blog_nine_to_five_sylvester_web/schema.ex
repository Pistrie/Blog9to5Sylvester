defmodule BlogNineToFiveSylvesterWeb.Schema do
  use Absinthe.Schema

  alias BlogNineToFiveSylvesterWeb.Resolvers

  object :post do
    field :id, non_null(:id)
    field :author, non_null(:string)
    field :text, non_null(:string)
    field :title, non_null(:string)

    field :comments, list_of(:comment) do
      arg(:id, :string)
      resolve(&Resolvers.Blog.load_comments/3)
    end
  end

  object :comment do
    field :id, non_null(:id)
    field :author, non_null(:string)
    field :text, non_null(:string)
    field :post_id, non_null(:integer)
  end

  query do
    @desc "Get all posts"
    field :all_posts, non_null(list_of(non_null(:post))) do
      resolve(&Resolvers.Blog.all_posts/3)
    end

    @desc "Get post by ID"
    field :post_by_id, :post do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Blog.get_post_by_id/3)
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

    @desc "Add comment to post"
    field :add_comment_to_post, :comment do
      arg(:author, non_null(:string))
      arg(:text, non_null(:string))
      arg(:post_id, non_null(:integer))

      resolve(&Resolvers.Blog.add_comment_to_post/3)
    end
  end
end
