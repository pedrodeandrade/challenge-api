defmodule ChallengeApi.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :text, :string
      add :user_id, references(:users, on_delete: :delete_all)
      timestamps()


    end

  end
end
