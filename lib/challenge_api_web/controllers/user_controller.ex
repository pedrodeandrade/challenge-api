defmodule ChallengeApiWeb.UserController do
  use ChallengeApiWeb, :controller

  alias ChallengeApi.Accounts
  alias ChallengeApi.Accounts.User
  alias ChallengeApi.Guardian

  action_fallback ChallengeApiWeb.FallbackController

  # request example = {user: {"name": "roberto", "age": "10", "cpf": "03457188231, "email": "roberto@gmail.com}, "password": "12345678"}
  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, token: token})
    end
  end

  # request example = {"email": "roberto@gmail.com", "password" "12345678"}
  def sign_in(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Accounts.sign_in_token(email, password) do
      conn
      |> render("user.json", %{user: user, token: token})
    end
  end
end
