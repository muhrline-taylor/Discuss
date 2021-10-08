defmodule Discuss.Web.FavoriteTopicController do
  use Discuss.Web, :controller

  alias Discuss.Web.Router.Helpers, as: Routes


  def favorite_topic(conn, params) do
    IO.puts("hello from favorite_topic")
  end


end
