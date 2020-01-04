defmodule ChallengeApiWeb.ArticleController do
  use ChallengeApiWeb, :controller

  alias ChallengeApi.Submissions
  alias ChallengeApi.Submissions.Article

  action_fallback ChallengeApiWeb.FallbackController

  def index(conn, _params) do
    articles = Submissions.list_articles()
    render(conn, "index.json", articles: articles)
  end

  def create(conn, %{"article" => article_params, "u_id" => user_id}) do
    with {:ok, %Article{} = article} <- Submissions.create_article(article_params, user_id) do
      conn
      |> put_status(:created)
      |> render("show.json", article: article)
    end
  end

  def show(conn, %{"id" => id}) do
    article = Submissions.get_article!(id)
    render(conn, "show.json", article: article)
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article = Submissions.get_article!(id)

    with {:ok, %Article{} = article} <- Submissions.update_article(article, article_params) do
      render(conn, "show.json", article: article)
    end
  end

  def delete(conn, %{"id" => id}) do
    article = Submissions.get_article!(id)

    with {:ok, %Article{}} <- Submissions.delete_article(article) do
      send_resp(conn, :no_content, "")
    end
  end
end
