defmodule Discuss.Web.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

  alias Discuss.Repo

  alias Discuss.Web.Router.Helpers, as: Routes

  import Ecto

  plug DiscussPlugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:update, :edit, :delete]

  def new(conn, _params) do

    changeset = Discuss.Topic.changeset(%Discuss.Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic} = params) do





    changeset = conn.assigns[:user]
    |> IO.inspect()
    |> Ecto.build_assoc(:topics)
    |> IO.inspect()
    |> Discuss.Topic.changeset(topic)


    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end



  end

  def index(conn, _params) do
    topics = Repo.all(Discuss.Topic)
    user =
      Discuss.User
      |> Repo.get(conn.assigns.user.id)
      |> Repo.preload(:favorite_topics)

    favorite_topics = user.favorite_topics
    IO.puts("++++++")
    IO.inspect(favorite_topics)
    IO.puts("++++++")
    render(conn, "index.html", topics: topics, favorite_topics: favorite_topics)
  end

  def show(conn, %{"id" => topic_id}) do
    topic = Repo.get!(Discuss.Topic, topic_id)
    render(conn, "show.html", topic: topic)
  end



  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Discuss.Topic, topic_id)
    changeset = Discuss.Topic.changeset(topic)

    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"_csrf_token" => _string, "_method" => _method, "discuss_topic" => topic, "id" => topic_id}) do

    old_topic = Repo.get(Discuss.Topic, topic_id)
    changeset = Discuss.Topic.changeset(old_topic, topic)



    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end

  end

  def delete(conn, %{"_csrf_token" => _csrf_token, "_method" => _method, "id" => topic_id}) do




    Repo.get!(Discuss.Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end






  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: Routes.topic_path(conn, :index))
      |> halt()
    end
  end

  def favorite(conn, params) do
    IO.puts("into favorite")
  end

end
