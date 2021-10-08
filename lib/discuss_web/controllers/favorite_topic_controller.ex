defmodule Discuss.Web.FavoriteTopicController do
  use Discuss.Web, :controller

  alias Discuss.Web.Router.Helpers, as: Routes
  alias Discuss.User
  alias Discuss.Topic
  alias Discuss.FavoriteTopics
  alias Discuss.Repo


  def favorite_topic(conn, %{"topic_id" => topic_id, "user_id" => user_id} = params) do


    user = Repo.get(Discuss.User, user_id)
    topic = Repo.get(Discuss.Topic, topic_id)

    IO.puts("++++++")
    IO.puts(topic.title)
    IO.puts(user.email)
    IO.puts("++++++")

    changeset = Discuss.FavoriteTopics.changeset(%FavoriteTopics{}, %{topic_id: topic_id, user_id: user_id})

    case Repo.insert(changeset) do
      {:ok, _favorited_topic} ->
        IO.puts("FAVORITE TOPIC CREATED")
        redirect(conn, to: Routes.topic_path(conn, :index))
      {:error, _reason} ->
        redirect(conn, to: Routes.topic_path(conn, :index))
    end



  end

  def delete(conn, %{"favorite_topic_id" => topic_id, "user_id" => user_id}) do
    IO.puts("+++++")
    IO.inspect(topic_id)
    IO.inspect(user_id)
    IO.puts("+++++")

    redirect(conn, to: Routes.topic_path(conn, :index))
  end


end
