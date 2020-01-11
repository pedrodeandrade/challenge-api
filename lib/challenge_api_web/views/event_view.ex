defmodule ChallengeApiWeb.EventView do
  use ChallengeApiWeb, :view
  alias ChallengeApiWeb.EventView
  alias ChallengeApiWeb.ArticleView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event, articles: article}) do
    %{
      id: event.id,
      name: event.name,
      description: event.description,
      date: event.date,
      articles: render_many(event.articles, ArticleView, "article.json")
    }
  end

  def render("event.json", %{event: event}) do
    %{id: event.id, name: event.name, description: event.description, date: event.date}
  end
end
