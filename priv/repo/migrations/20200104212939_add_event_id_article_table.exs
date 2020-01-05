defmodule ChallengeApi.Repo.Migrations.AddEventIdArticleTable do
  use Ecto.Migration

  def change do
    alter table (:articles) do
      add :event_id, references(:events, on_delete: :delete_all)
    end
  end
end
