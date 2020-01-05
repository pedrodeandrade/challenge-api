defmodule ChallengeApi.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :date, :string
    field :description, :string
    field :name, :string

    has_many :articles, ChallengeApi.Submissions.Article
    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :description, :date])
    |> validate_required([:name, :description, :date])
  end
end
