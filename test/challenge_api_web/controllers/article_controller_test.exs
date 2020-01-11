defmodule ChallengeApiWeb.ArticleControllerTest do
  use ChallengeApiWeb.ConnCase

  alias ChallengeApi.Submissions
  alias ChallengeApi.Submissions.Article

  @create_attrs %{
    text: "some text",
    title: "some_title",
    event_id: "1"
  }

  @user_id 1

  @invalid_attrs %{text: nil, title: nil, event_id: nil}

  def fixture(:article) do
    {:ok, article} = Submissions.create_article(@create_attrs)
    article
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end



  describe "create article" do
    test "renders article when data is valid", %{conn: conn} do
      conn = post(conn, Routes.article_path(conn, :create), article: @create_attrs, u_id: @user_id)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.article_path(conn, :show, id))

      assert %{
               "id" => id,
               "text" => "some text"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.article_path(conn, :create), article: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_article(_) do
    article = fixture(:article)
    {:ok, article: article}
  end
end
