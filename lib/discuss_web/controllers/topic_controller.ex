defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias DiscussTopic

  alias Discuss.Repo

  alias DiscussWeb.Router.Helpers, as: Routes

  plug DiscussPlugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]

  def new(conn, _params) do

    changeset = DiscussTopic.changeset(%DiscussTopic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"_csrf_token" => string, "discuss_topic" => title}) do


    changeset = DiscussTopic.changeset(%DiscussTopic{}, title)

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
    IO.inspect(conn.assigns)
    topics = Repo.all(DiscussTopic)
    render(conn, "index.html", topics: topics)
  end



  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(DiscussTopic, topic_id)
    changeset = DiscussTopic.changeset(topic)

    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"_csrf_token" => _string, "_method" => _method, "discuss_topic" => topic, "id" => topic_id}) do

    old_topic = Repo.get(DiscussTopic, topic_id)
    changeset = DiscussTopic.changeset(old_topic, topic)



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




    Repo.get!(DiscussTopic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end





end
