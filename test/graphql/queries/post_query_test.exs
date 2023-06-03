defmodule BlogNineToFiveSylvester.Graphql.Queries.PostQueryTest do
  use BlogNineToFiveSylvesterWeb.ConnCase, async: true

  import BlogNineToFiveSylvester.BlogFixtures

  @query """
  query GetPostById($id: ID!) {
    postById(id: $id) {
      author
      title
      text
    }
  }
  """

  test "get single post", %{conn: conn} do
    post = post_fixture()

    variables = %{
      id: post.id
    }

    conn =
      post(conn, "/api/graphiql", %{
        "query" => @query,
        "variables" => variables
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
