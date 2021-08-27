defmodule DiscussWeb.CommentsChannel do
  use Phoenix.Channel

  def join(name, _params, socket) do
    IO.puts("++++++++++++")
    IO.puts(name)
    {:ok, %{hey: "there are me"}, socket}

  end

  def handle_in() do

  end
end
