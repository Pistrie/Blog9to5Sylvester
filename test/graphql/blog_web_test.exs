defmodule BlogNineToFiveSylvesterWeb.SchemaTest do
  use BlogNineToFiveSylvesterWeb.ConnCase

  import BlogNineToFiveSylvester.BlogFixtures

  describe "posts" do
    #
    # TEST LIST ALL POSTS
    #
    test "list all posts", %{conn: conn} do
      user_query = """
      query {
        allPosts {
          author
          title
          text
          #comments {
          #  author
          #  text
          #}
        }
      }
      """

      post = post_fixture()
      # comment = comment_fixture(post.id)

      conn =
        post(conn, "/api/graphiql", %{
          "query" => user_query
        })

      assert json_response(conn, 200) == %{
               "data" => %{
                 "allPosts" => [
                   %{
                     "author" => post.author,
                     "title" => post.title,
                     "text" => post.text
                     # "comments" => [
                     #  %{
                     #    "author" => comment.author,
                     #    "text" => comment.text
                     #  }
                     # ]
                   }
                 ]
               }
             }
    end

    #
    # TEST GET SINGLE POST
    #
    test "get single post", %{conn: conn} do
      user_query = """
      query GetPostById($id: ID!) {
        postById(id: $id) {
          author
          title
          text
          comments {
            author
            text
          }
        }
      }
      """

      post = post_fixture()
      comment = comment_fixture(post.id)

      conn =
        post(conn, "/api/graphiql", %{
          "query" => user_query,
          "variables" => %{id: post.id}
        })

      assert json_response(conn, 200) == %{
               "data" => %{
                 "postById" => %{
                   "author" => post.author,
                   "title" => post.title,
                   "text" => post.text,
                   "comments" => [
                     %{
                       "author" => comment.author,
                       "text" => comment.text
                     }
                   ]
                 }
               }
             }
    end
  end

  describe "comments" do
    #
    # TEST ADD COMMENT TO POST
    #
    test "add comment to post", %{conn: conn} do
      user_query = """
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

      post = post_fixture()

      valid_attrs = %{post_id: post.id, author: "some author", text: "some text"}

      conn =
        post(conn, "/api/graphiql", %{
          "query" => user_query,
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

    #
    # TEST ADD COMMENT WITH INVALID DATA
    #
    test "add comment with invalid data should return error", %{conn: conn} do
      user_query = """
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

      post = post_fixture()

      invalid_attrs = %{post_id: post.id, author: "s", text: "some text"}

      conn =
        post(conn, "/api/graphiql", %{
          "query" => user_query,
          "variables" => %{
            postId: invalid_attrs.post_id,
            author: invalid_attrs.author,
            text: invalid_attrs.text
          }
        })

      assert %{
               "data" => %{"addCommentToPost" => nil},
               "errors" => [
                 %{
                   "locations" => locations,
                   "message" => "author: should be at least 2 character(s). ",
                   "path" => ["addCommentToPost"]
                 }
               ]
             } = json_response(conn, 200)

      assert is_list(locations)
    end
  end
end
