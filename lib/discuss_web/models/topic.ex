defmodule Discuss.Topic do
  use Discuss.Web, :model

  schema "topics" do
    field :title, :string
    # Many to One
    belongs_to :user, Discuss.User
    has_many :comments, Discuss.Comment
    many_to_many :users_favorites, Discuss.User,
      join_through: Discuss.FavoriteTopics
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end

end
