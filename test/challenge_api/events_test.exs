defmodule ChallengeApi.EventsTest do
  use ChallengeApi.DataCase

  alias ChallengeApi.Events

  describe "events" do
    alias ChallengeApi.Events.Event

    @valid_attrs %{date: "09/01/2020", description: "some description", name: "some name"}

    @invalid_attrs %{date: nil, description: nil, name: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event =
              event_fixture()
              |> remove_articles

      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event =
              event_fixture()
              |> remove_articles

      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Events.create_event(@valid_attrs)
      assert event.date == "09/01/2020"
      assert event.description == "some description"
      assert event.name == "some name"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    def remove_articles (event) do
      Map.replace!(event,:articles,[])
    end
  end
end
