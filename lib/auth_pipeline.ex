defmodule ChallengeApi.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :ChallengeApi,
    module: ChallengeApi.Guardian,
    error_handler: ChallengeApi.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
