defmodule DiscussPlugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Repo

  alias DiscussUser

  # alias DiscussWeb.Router.Helpers, as: Routes

  def init(_params) do



  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get(DiscussUser, user_id) ->
        assign(conn, :user, user)
      true ->
        assign(conn, :user, nil)
    end
  end


end
