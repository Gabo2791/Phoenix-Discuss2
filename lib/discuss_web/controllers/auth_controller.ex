defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  alias Discuss.Schema.User

  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
    changeset = User.changeset(%User{}, user_params)
  end
end
