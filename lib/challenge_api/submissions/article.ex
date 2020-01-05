defmodule ChallengeApi.Submissions.Article do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChallengeApi.Accounts.User
  alias ChallengeApi.Events.Event

  schema "articles" do
    field :title, :string
    field :text, :string

    belongs_to :user, User, foreign_key: :user_id
    belongs_to :event, Event, foreign_key: :event_id

    timestamps()
  end

  @doc false
  def changeset(article, attrs, user_id) do
    {:ok, user_id} = Ecto.Type.cast(:integer, user_id)

    article
    |> cast(attrs, [:title, :text,:user_id, :event_id])
    |> validate_required([:title, :text, :event_id])
    |> change(user_id: user_id)
  end
end


#SELECT articles.title, articles.text, users.name, events.name FROM articles,users,events where users.id = articles.user_id and articles.event_id = events.id;
