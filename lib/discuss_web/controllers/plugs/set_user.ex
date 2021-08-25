defmodule DiscussWeb.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  # El objetivo de este enchufe es mirar la conexion de conn.
  alias Discuss.Repo
  alias Discuss.Schema.User

  def init(_params) do

  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)
        #conn.assigns.user => user struct
      true ->
        assign(conn, :user, nil)
    end
  end
end
