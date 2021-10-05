defmodule DiscussTopic do
  use DiscussWeb, :model

  schema "topics" do
    field :title, :string
    # Many to One
    belongs_to :user, DiscussUser
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end

end
