defmodule ChallengeApi.AccountsTest do
  use ChallengeApi.DataCase

  alias ChallengeApi.Accounts

  describe "users" do
    alias ChallengeApi.Accounts.User

    @valid_attrs %{
      age: 42,
      cpf: "13213213212",
      name: "some name",
      email: "teste@gmail.com",
      password: "12345678"
    }
    @invalid_attrs %{age: "0", cpf: "199222", name: nil, email: "email_adress", password: "123"}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "get_user!/1 returns the user with given id" do
      user =
        user_fixture(@valid_attrs)
        |> remove_pw

      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "sign_in_token/2 with valid data returns user and token" do
      user = user_fixture(@valid_attrs)
      assert {:ok, user, token} = Accounts.sign_in_token(user.email, user.password)
    end

    def remove_pw(user) do
      Map.replace!(user, :password, nil)
    end
  end
end
