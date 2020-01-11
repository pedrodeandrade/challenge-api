defmodule ChallengeApi.Submissions do
  @moduledoc """
  The Submissions context.
  """

  import Ecto.Query, warn: false
  alias ChallengeApi.Repo

  alias ChallengeApi.Submissions.Article


  @doc """
  Creates a article.

  ## Examples

      iex> create_article(%{field: value})
      {:ok, %Article{}}

      iex> create_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article(attrs \\ %{}, user_id) do
    %Article{}
    |> Article.changeset(attrs, user_id)
    |> Repo.insert()
  end
end
