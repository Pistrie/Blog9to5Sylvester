defmodule BlogNineToFiveSylvesterWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types(BlogNineToFiveSylvester.Graphql.Types.Post)
  import_types(BlogNineToFiveSylvester.Graphql.Types.Comment)

  query do
    import_types(BlogNineToFiveSylvester.Graphql.Queries.Post)

    import_fields(:post_queries)
  end

  mutation do
    import_types(BlogNineToFiveSylvester.Graphql.Mutations.Post)
    import_types(BlogNineToFiveSylvester.Graphql.Mutations.Comment)

    import_fields(:post_mutations)
    import_fields(:comment_mutations)
  end

  def context(absinthe_context) do
    default_source = BlogNineToFiveSylvester.GraphQL.Helpers.Dataloader.data()

    loader =
      [
        BlogNineToFiveSylvester.Blog.Comment
      ]
      |> Enum.reduce(Dataloader.new(), &Dataloader.add_source(&2, &1, default_source))

    Map.put(absinthe_context, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
