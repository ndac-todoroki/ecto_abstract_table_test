defmodule EctoAbstractTableTest.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias EctoAbstractTableTest.Blog.Comment

  schema "posts" do
    has_many :comments, {"posts_comments", Comment}, foreign_key: :assoc_id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [])
  end
end
