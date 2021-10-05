defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  plug Ueberauth

  alias DiscussUser
  # alias Discuss.User

  alias Discuss.Repo

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do



    auth_token = auth.credentials.token

    user_params = %{token: auth_token, email: auth.info.email, provider: "github"}
    changeset = DiscussUser.changeset(%DiscussUser{}, user_params)

    signin(conn, changeset)

  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: Routes.topic_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(DiscussUser, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end




end
