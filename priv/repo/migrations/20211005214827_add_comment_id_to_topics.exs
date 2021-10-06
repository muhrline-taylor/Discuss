defmodule Discuss.Repo.Migrations.AddCommentIdToTopics do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :comment_id, references(:comments)
    end
  end
end
