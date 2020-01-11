defmodule ChallengeApiWeb.ArticleController do
  use ChallengeApiWeb, :controller

  alias ChallengeApi.Submissions
  alias ChallengeApi.Submissions.Article
  alias ChallengeApi.Guardian

  action_fallback ChallengeApiWeb.FallbackController

  # request sample  {"article":{"title": "foo", "text": "bar", "event_id": 1}}
  def create(conn, %{"article" => article_params, "u_id" => user_id}) do
    with {:authorized} <- Guardian.auth(conn, user_id),
         {:ok, %Article{} = article} <- Submissions.create_article(article_params, user_id) do
      conn
      |> put_status(:created)
      |> render("show.json", article: article)
    end
  end
end
