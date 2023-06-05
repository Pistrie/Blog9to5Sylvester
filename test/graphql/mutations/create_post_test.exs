defmodule Graphql.Mutations.CreatePostTest do
  use BlogNineToFiveSylvesterWeb.ConnCase, async: true

  @query """
  mutation CreatePost($input: CreatePostInput!) {
    createPost(createPost: $input) {
      author
      title
      text
    }
  }
  """

  test "create post", %{conn: conn} do
    variables = %{
      input: %{
        author: "some author",
        title: "some title",
        text: "some text"
      }
    }

    conn =
      post(conn, "/api/graphiql", %{
        "query" => @query,
        "variables" => variables
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "createPost" => %{
                 "author" => variables.input.author,
                 "title" => variables.input.title,
                 "text" => variables.input.text
               }
             }
           }
  end

  test "create post with invalid data should return error", %{conn: conn} do
    variables = %{
      input: %{
        author: "s",
        title: "s",
        text: "some text"
      }
    }

    conn =
      post(conn, "/api/graphiql", %{
        "query" => @query,
        "variables" => variables
      })

    assert %{
             "data" => %{"createPost" => nil},
             "errors" => [
               %{
                 "locations" => _locations,
                 "message" =>
                   "author: should be at least 2 character(s). title: should be at least 2 character(s).",
                 "path" => ["createPost"]
               }
             ]
           } = json_response(conn, 200)
  end
end
