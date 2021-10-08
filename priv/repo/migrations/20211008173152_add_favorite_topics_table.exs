defmodule Discuss.Repo.Migrations.AddFavoriteTopicsTable do
  use Ecto.Migration

  def change do
    create table(:favorite_topics) do
      add :topic_id, :user_id
    end
  end
end
