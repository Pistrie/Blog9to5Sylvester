defmodule BlogNineToFiveSylvester.Graphql.Queries.PostsQueryTest do
  use BlogNineToFiveSylvesterWeb.ConnCase, async: true

  import BlogNineToFiveSylvester.BlogFixtures

  @query """
  query ListPosts {
    allPosts {
      id
    }
  }
  """

  test "get single post", %{conn: conn} do
    post1 = post_fixture()
    post2 = post_fixture()

    conn =
      post(conn, "/api/graphiql", %{
        query: @query
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "postById" => %{
                 "author" => post.author,
                 "title" => post.title,
                 "text" => post.text
               }
             }
           }
  end
end
