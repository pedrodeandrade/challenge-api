defmodule ChallengeApiWeb.PageController do
  use ChallengeApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
