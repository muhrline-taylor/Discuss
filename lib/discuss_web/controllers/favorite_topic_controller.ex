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

  def delete(conn, %{"favorite_topic_id" => raw_topic_id, "user_id" => raw_user_id}) do
    {topic_id, _q} = Integer.parse(raw_topic_id)
    {user_id, _q} = Integer.parse(raw_user_id)

    favorite_topics = Repo.all(Discuss.FavoriteTopics)


      for favorite_topic <- favorite_topics do


        if favorite_topic.user_id === user_id && favorite_topic.topic_id === topic_id do
          IO.puts("FOUND THE FAVORITE TOPIC")
          Repo.delete!(favorite_topic)
        end

      end



    redirect(conn, to: Routes.topic_path(conn, :index))
  end


end
