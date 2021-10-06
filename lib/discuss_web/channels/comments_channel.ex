defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel
  alias Discuss.Topic
  alias Discuss.Repo
  alias Discuss.Comment
  import Ecto

  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Discuss.Topic
    |> Repo.get(topic_id)
    |> Repo.preload(:comments)
    |> IO.inspect()

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    topic = socket.assigns.topic

    changeset = topic
      |> Ecto.build_assoc(:comments)
      |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end


  end

end
