defmodule Discuss.Schema.User do
  @moduledoc """

  """
  use DiscussWeb, :schema

  @derive {Jason.Encoder, only: [:email]}
  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    has_many :topics, Discuss.Schema.Topic
    has_many :comments, Discuss.Schema.Comment

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:provider])
  end
end
