defmodule ChallengeApiWeb.UserView do
  use ChallengeApiWeb, :view
  alias ChallengeApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(%{user: user}, UserView, "user.json")}
  end

  def render("user.json", %{user: user, token: token}) do
    %{
      id: user.id,
      email: user.email,
      name: user.name,
      token: token
    }
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      name: user.name,
      age: user.age,
      cpf: user.cpf
    }
  end
end
