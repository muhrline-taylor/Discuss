defmodule Discuss.Web.UserSocket do
  use Phoenix.Socket

  channel "comments:*", Discuss.CommentsChannel

  @impl true
  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "key", token) do
      {:ok, user_id} ->
        {:ok, assign(socket, :user_id, user_id)}
      {:error, _reason} ->

    end
  end


  @impl true
  def id(_socket), do: nil
end
