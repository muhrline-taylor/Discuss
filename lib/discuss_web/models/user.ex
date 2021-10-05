defmodule DiscussUser do
  use DiscussWeb, :model

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    # One to Many
    has_many :topics, DiscussTopic

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
  struct
  |> cast(params, [:email, :provider, :token])
  |> validate_required([:email, :provider, :token])
  end
end
