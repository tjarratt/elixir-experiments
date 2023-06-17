defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.Comments.Comment

  schema "posts" do
    field :body, :string
    field :title, :string
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end

  def add_comment(post_id, comment_params) do
    comment_params
    |> Map.put("post_id", post_id)
    |> Comments.create_comment()
  end
end
