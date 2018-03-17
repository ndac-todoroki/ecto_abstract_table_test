defmodule EctoAbstractTableTest.Blog.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "abstract table: comments" do
    # This will be used by associations on each "concrete" table
    field :assoc_id, :integer

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [])
    |> foreign_key_constraint(:assoc_id)
  end
end
