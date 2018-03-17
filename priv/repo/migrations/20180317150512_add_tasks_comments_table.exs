defmodule EctoAbstractTableTest.Repo.Migrations.AddTasksCommentsTable do
  use Ecto.Migration

  def change do
    create table(:tasks_comments) do
      add :assoc_id, references(:tasks, on_delete: :nothing)

      timestamps()
    end
  end
end
