defmodule EctoAbstractTableTest.Repo.Migrations.AddTasksTable do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      timestamps()
    end
  end
end
