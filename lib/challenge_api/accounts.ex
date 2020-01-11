defmodule ChallengeApi.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  import Comeonin.Bcrypt

  alias ChallengeApi.Repo
  alias ChallengeApi.Accounts.User
  alias ChallengeApi.Guardian

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Sign in user and return a token

  ## Examples
      iex> sign_in_token(email, password)
      {:ok,user,token}

      iex> sign_in_token(wrong_email, wrong_password)
      {:error, :unauthorized}

  """
  def sign_in_token(email, password) do
    with {:ok, user} <- get_by_email(email) do
      case check_password(password, user) do
        {:ok, user} ->
          {:ok, token, _claims} = Guardian.encode_and_sign(user)
          {:ok, user, token}

        _ ->
          {:error, :unauthorized}
      end
    end
  end

  @doc """
  Get user by id

  ## Examples
      iex> get_user!(id)
      %User{}

      iex> get_user!(invalid_id)
      Ecto.NoResultsError
  """
  def get_user!(id) do
    Repo.get!(User, id)
  end

  defp get_by_email(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        {:error, :email_not_found}

      user ->
        {:ok, user}
    end
  end

  defp check_password(password, user) do
    case checkpw(password, user.encrypted_password) do
      true ->
        {:ok, user}

      false ->
        {:error, :invalid_password}
    end
  end
end
