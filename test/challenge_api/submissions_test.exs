defmodule ChallengeApi.SubmissionsTest do
  use ChallengeApi.DataCase

  alias ChallengeApi.Submissions
  alias ChallengeApi.Accounts
  alias ChallengeApi.Events
  describe "articles" do
    alias ChallengeApi.Submissions.Article

    @valid_attrs %{title: "some title",text: "some text"}
    @invalid_attrs %{text: nil,text: nil,event_id: nil}
    @user_id

    @valid_user_attrs %{
      age: 42,
      cpf: "13213213212",
      name: "some name",
      email: "teste@gmail.com",
      password: "12345678"
    }

    @valid_event_attrs %{date: "09/01/2020", description: "some description", name: "some name"}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_user_attrs)
        |> Accounts.create_user()

      user
    end

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_event_attrs)
        |> Events.create_event()

      event
    end

    test "create_article/1 with valid data creates a article" do
      user = user_fixture(@valid_user_attrs)
      event = event_fixture(@valid_event_attrs)
      article_attrs = add_event_id(@valid_attrs, event)

      assert {:ok, %Article{} = article} = Submissions.create_article(article_attrs,user.id)
      assert article.text == "some text"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Submissions.create_article(@invalid_attrs,@user_id)
    end

    def add_event_id(article_attrs, event) do
      Map.put(article_attrs,:event_id, event.id)
    end
  end
end
