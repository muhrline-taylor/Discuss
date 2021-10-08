defmodule Discuss.Web.FavoriteTopicController do
  use Discuss.Web, :controller

  alias Discuss.Web.Router.Helpers, as: Routes


  def favorite_topic(conn, %{"topic_id" => topic_id, "user_id" => user_id} = params) do
    IO.puts("++++++")
    IO.puts(topic_id)
    IO.puts(user_id)
    IO.puts("++++++")
  end


end
