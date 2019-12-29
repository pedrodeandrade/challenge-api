defmodule ChallengeApi.Repo do
  use Ecto.Repo,
    otp_app: :challenge_api,
    adapter: Ecto.Adapters.Postgres
end
