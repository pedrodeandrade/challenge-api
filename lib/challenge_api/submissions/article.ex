defmodule ChallengeApi.Submissions.Article do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChallengeApi.Accounts.User

  schema "articles" do
    field :title, :string
    field :text, :string

    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(article, attrs,user_id) do
    {:ok,user_id} = Ecto.Type.cast(:integer, user_id)

    article
    |> cast(attrs, [:title,:text,:user_id])
    |> validate_required([:text])
    |> change(user_id: user_id)

  end
end
