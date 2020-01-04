defmodule ChallengeApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do 
    field :age, :integer
    field :cpf, :string
    field :name, :string

    has_many :articles, ChallengeApi.Submissions.Article

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :cpf, :age])
    |> validate_length(:cpf,is: 11)
    |> validate_number(:age, greater_than: 0)
    |> validate_required([:name, :cpf, :age])
  end
end
