defmodule ChallengeApi.SubmissionsTest do
  use ChallengeApi.DataCase

  alias ChallengeApi.Submissions

  describe "articles" do
    alias ChallengeApi.Submissions.Article

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def article_fixture(attrs \\ %{}) do
      {:ok, article} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Submissions.create_article()

      article
    end

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Submissions.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Submissions.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      assert {:ok, %Article{} = article} = Submissions.create_article(@valid_attrs)
      assert article.text == "some text"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Submissions.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      assert {:ok, %Article{} = article} = Submissions.update_article(article, @update_attrs)
      assert article.text == "some updated text"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Submissions.update_article(article, @invalid_attrs)
      assert article == Submissions.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Submissions.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Submissions.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Submissions.change_article(article)
    end
  end
end
