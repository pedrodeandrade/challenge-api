defmodule ChallengeApiWeb.UserControllerTest do
  use ChallengeApiWeb.ConnCase

  alias ChallengeApi.Accounts
  alias ChallengeApi.Accounts.User

  @create_attrs %{
    age: 42,
    cpf: "02002020213",
    name: "some name",
    email: "exemplo@gmail.com",
    password: "12345678"
  }

  @invalid_attrs %{age: 0, cpf: "123", name: "aaa", email: "email", password: "123" }

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end


  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
          age: 42,
          cpf: "02002020213",
          name: "some name",
          email: "exemplo@gmail.com",
          password: "12345678"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
