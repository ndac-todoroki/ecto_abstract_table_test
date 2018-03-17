defmodule EctoAbstractTableTest.Blog do
  import Ecto.Query, warn: false
  alias EctoAbstractTableTest.Repo
  alias EctoAbstractTableTest.Blog.{Post, Task, Comment}

  @commentable_modules [Post, Task]

  def list_posts do
    Repo.all(Post)
  end

  def list_tasks do
    Repo.all(Task)
  end

  def list_comments do
    Repo.all(Comment)
  end

  def list_comments(%c{} = commentable) when c in @commentable_modules do
    commentable
    |> Ecto.assoc(:comments)
    |> Repo.all()
  end

  def create_post do
    %Post{}
    |> Post.changeset(%{})
    |> Repo.insert()
  end

  def create_task do
    %Task{}
    |> Task.changeset(%{})
    |> Repo.insert()
  end

  def create_comment(%c{} = commentable) when c in @commentable_modules do
    commentable
    |> Ecto.build_assoc(:comments, %{})
    |> Repo.insert()
  end
end
