defmodule BlogNineToFiveSylvester.Graphql.Queries.PostsQueryTest do
  use BlogNineToFiveSylvesterWeb.ConnCase

  import BlogNineToFiveSylvester.BlogFixtures

  @query """
  query ListPosts {
    allPosts {
      id
      author
      title
      text
    }
  }
  """

  test "get posts", %{conn: conn} do
    post1 = post_fixture(%{title: "title A"})
    post2 = post_fixture(%{title: "title B"})

    conn =
      post(conn, "/api/graphiql", %{
        query: @query
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "allPosts" => [
                 %{
                   "author" => post1.author,
                   "id" => post1.id |> Integer.to_string(),
                   "text" => post1.text,
                   "title" => post1.title
                 },
                 %{
                   "author" => post2.author,
                   "id" => post2.id |> Integer.to_string(),
                   "text" => post2.text,
                   "title" => post2.title
                 }
               ]
             }
           }
  end
end
