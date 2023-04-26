# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BlogNineToFiveSylvester.Repo.insert!(%BlogNineToFiveSylvester.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BlogNineToFiveSylvester.Blog.Post
alias BlogNineToFiveSylvester.Blog.Comment
alias BlogNineToFiveSylvester.Repo

Repo.delete_all(Comment)
Repo.delete_all(Post)

{:ok, _post} =
  %Post{
    author: "José Valim",
    title: "Blog post #1",
    text: "This is a very interesting blog post",
    comments: [
      %Comment{
        text: "Good post",
        author: "John Doe"
      },
      %Comment{
        text: "Love it!",
        author: "Ada Lovelace"
      }
    ]
  }
  |> Repo.insert()
  |> IO.inspect()
