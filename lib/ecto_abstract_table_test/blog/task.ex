defmodule EctoAbstractTableTest.Blog.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias EctoAbstractTableTest.Blog.Comment

  schema "tasks" do
    has_many :comments, {"tasks_comments", Comment}, foreign_key: :assoc_id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [])
  end
end
