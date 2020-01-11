defmodule ChallengeApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt

  schema "users" do
    field :age, :integer
    field :cpf, :string
    field :name, :string
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true

    has_many :articles, ChallengeApi.Submissions.Article

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :cpf, :age, :email, :password])
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than: 0)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> unique_constraint(:email)
    |> validate_required([:name, :cpf, :age, :email, :password])
    |> put_hashing_pw
  end

  defp put_hashing_pw(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :encrypted_password, hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
