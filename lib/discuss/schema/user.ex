defmodule Discuss.Schema.User do
    @moduledoc """

  """
  use DiscussWeb, :schema

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    has_many :topics, Discuss.Schema.Topic

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:provider])
  end
end
