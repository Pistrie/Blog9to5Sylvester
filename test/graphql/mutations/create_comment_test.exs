defmodule Graphql.Mutations.CreateCommentTest do
  use BlogNineToFiveSylvesterWeb.ConnCase, async: true

  import BlogNineToFiveSylvester.BlogFixtures

  @query """
  mutation CreateComment($postId: Int!, $author: String!, $text: String!) {
    addCommentToPost(
      postId: $postId,
      author: $author,
      text: $text
    ) {
      postId
      author
      text
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
          postId: valid_attrs.post_id,
          author: valid_attrs.author,
          text: valid_attrs.text
        }
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "addCommentToPost" => %{
                 "author" => valid_attrs.author,
                 "postId" => valid_attrs.post_id,
                 "text" => valid_attrs.text
               }
             }
           }
  end
end
