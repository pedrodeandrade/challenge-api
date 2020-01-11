defmodule ChallengeApi.Guardian do
  use Guardian, otp_app: :challenge_api

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = ChallengeApi.Accounts.get_user!(id)
    {:ok, resource}
  end

  def auth(conn, id) do
    user = Guardian.Plug.current_resource(conn)
    {u_id, _} = Integer.parse(id)

    case u_id == user.id do
      true ->
        {:authorized}

      false ->
        {:error, :unauthorized}
    end
  end
end
