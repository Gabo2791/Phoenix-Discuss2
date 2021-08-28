defmodule Discuss.Schema.Comment do
  @moduledoc """

  """
  use DiscussWeb, :schema

  @derive {Jason.Encoder, only: [:content, :user]}

  schema "comments" do
    field :content, :string
    belongs_to :topic, Discuss.Schema.Topic
    belongs_to :user, Discuss.Schema.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
