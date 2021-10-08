defmodule Discuss.FavoriteTopics do
  use Discuss.Web, :model

  schema "favorite_topics" do
    belongs_to :user, Discuss.User
    belongs_to :topic, Discuss.Topic

    timestamps()
  end



end
