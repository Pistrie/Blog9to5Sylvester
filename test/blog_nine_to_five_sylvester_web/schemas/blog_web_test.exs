defmodule BlogNineToFiveSylvesterWeb.SchemaTest do
  use BlogNineToFiveSylvesterWeb.ConnCase

  import BlogNineToFiveSylvester.BlogFixtures

  # TODO tests to make: create post, create comment, list all posts (with comments), list single post (with comments)

  describe "posts" do
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

    test "create post", %{conn: conn} do
      user_query = """
      mutation CreatePost($author: String!, $title: String!, $text: String!) {
        createPost(
          author: $author,
          title: $title,
          text: $text
        ) {
          author
          title
          text
        }
      }
      """

      valid_attrs = %{author: "some author", title: "some title", text: "some text"}

      conn =
        post(conn, "/api/graphiql", %{
          "query" => user_query,
          "variables" => %{
            author: valid_attrs.author,
            title: valid_attrs.title,
            text: valid_attrs.text
          }
        })

      assert json_response(conn, 200) == %{
               "data" => %{
                 "createPost" => %{
                   "author" => valid_attrs.author,
                   "title" => valid_attrs.title,
                   "text" => valid_attrs.text
                 }
               }
             }
    end
  end

  describe "comments" do
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
  end
end
