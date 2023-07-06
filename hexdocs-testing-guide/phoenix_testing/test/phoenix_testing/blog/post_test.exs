defmodule PhoenixTesting.Blog.PostTest do
  use PhoenixTesting.DataCase, async: true
  alias PhoenixTesting.Blog.Post

  test "Title must be at least two characters long" do
    changeset = Post.changeset(%Post{}, %{title: "I"})
    assert %{title: ["should be at least 2 character(s)"]} = errors_on(changeset)
  end
end
