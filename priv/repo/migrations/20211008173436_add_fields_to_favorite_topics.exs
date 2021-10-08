defmodule Discuss.Repo.Migrations.AddFieldsToFavoriteTopics do
  use Ecto.Migration

  def change do
    alter table(:favorite_topics) do
      add :topic_id, references(:topics)
      add :user_id, references(:users)
    end
  end
end
