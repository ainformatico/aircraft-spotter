defmodule Aircraft.EventsTest do
  use Aircraft.DataCase

  alias Aircraft.Events

  describe "events" do
    alias Aircraft.Events.Event

    @valid_attrs %{
      "timestamp" => DateTime.utc_now(),
      "data" => %{
        "hex" => "abcd"
      }
    }

    @invalid_attrs %{
      "timestamp" => nil,
      "data" => nil
    }

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_event()

      event
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Events.create_event(@valid_attrs)
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end
  end
end
