defmodule ChallengeApiWeb.EventController do
  use ChallengeApiWeb, :controller

  alias ChallengeApi.Events
  alias ChallengeApi.Events.Event

  action_fallback ChallengeApiWeb.FallbackController

  def index(conn, _params) do
    events = Events.list_events()
    render(conn, "index.json", events: events)
  end

  # request sample  {"article":{"name": "foo event", "description": "bar event", "date": "02/02/2002"}}
  def create(conn, %{"event" => event_params}) do
    with {:ok, %Event{} = event} <- Events.create_event(event_params) do
      conn
      |> put_status(:created)
      |> render("show.json", event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Events.get_event!(id)
    render(conn, "event.json", %{event: event, articles: true})
  end
end
