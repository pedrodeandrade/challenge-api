defmodule ChallengeApi.Submissions.Article do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChallengeApi.Accounts.User

  schema "articles" do
    field :text, :string

    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
