defmodule Graphql.Mutations.CreateCommentTest do
  use BlogNineToFiveSylvesterWeb.ConnCase, async: true

  import BlogNineToFiveSylvester.BlogFixtures

  @query """
  mutation addCommentToPost($input: CreateCommentInput!) {
    addCommentToPost(createComment: $input) {
      author
      postId
    }
  }
  """

  test "add comment to post", %{conn: conn} do
    post = post_fixture()

    valid_attrs = %{post_id: post.id, author: "some author", text: "some text"}

    conn =
      post(conn, "/api/graphiql", %{
        "query" => @query,
        "variables" => %{
          input: %{
            post_id: valid_attrs.post_id,
            author: valid_attrs.author,
            text: valid_attrs.text
          }
        }
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "addCommentToPost" => %{
                 "postId" => valid_attrs.post_id |> Integer.to_string(),
                 "author" => valid_attrs.author
               }
             }
           }
  end

  test "unable to add comment with invalid data", %{conn: conn} do
    post = post_fixture()

    invalid_attrs = %{post_id: post.id, author: "a", text: "some text"}

    conn =
      conn
      |> post("/api/graphiql", %{
        "query" => @query,
        "variables" => %{
          input: invalid_attrs
        }
      })

    assert json_response(conn, 200) == %{
             "data" => %{"addCommentToPost" => nil},
             "errors" => [
               %{
                 "locations" => [%{"column" => 3, "line" => 2}],
                 "message" => "author: should be at least 2 character(s).",
                 "path" => ["addCommentToPost"]
               }
             ]
           }
  end
end
