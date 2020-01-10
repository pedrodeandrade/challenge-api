defmodule ChallengeApi.Repo.Migrations.AddEncryptedPasswordUserTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :email, :string
      add :encrypted_password, :string
    end
  end
end
