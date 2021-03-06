defmodule Discuss.Schema.User do
    @moduledoc """
  
  """
  use DiscussWeb, :schema

  schema "topics" do
    field :email, :string
    field :provider, :string
    field :token, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:provider])
  end
end
