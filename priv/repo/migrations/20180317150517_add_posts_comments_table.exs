defmodule EctoAbstractTableTest.Repo.Migrations.AddPostsCommentsTable do
  use Ecto.Migration

  def change do
    create table(:posts_comments) do
      add :assoc_id, references(:posts, on_delete: :nothing)

      timestamps()
    end
  end
end
