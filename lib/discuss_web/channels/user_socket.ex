defmodule Discuss.Web.UserSocket do
  use Phoenix.Socket

  channel "comments:*", Discuss.CommentsChannel

  @impl true
  def connect(%{"token" => token}, socket) do
    IO.puts("+++++")
    IO.puts(token)
    {:ok, socket}
  end


  @impl true
  def id(_socket), do: nil
end
