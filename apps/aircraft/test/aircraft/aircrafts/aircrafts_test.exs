defmodule Aircraft.AircraftsTest do
  use Aircraft.DataCase, async: true

  alias Aircraft.Aircrafts

  describe "aircrafts" do
    alias Aircraft.Aircrafts.Aircraft

    @valid_attrs %{
      icao: "abcd",
      category: "Category",
      registration_country: "Spain",
      model: "A320",
      last_seen: DateTime.utc_now()
    }

    @update_attrs %{
      category: "Other",
      registration_country: "Portugal"
    }
    @invalid_attrs %{
      icao: nil
    }

    def aircraft_fixture(attrs \\ %{}) do
      {:ok, aircraft} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Aircrafts.create_aircraft()

      aircraft
    end

    test "list_aircrafts/0 returns all aircrafts" do
      aircraft_fixture()
      aircraft_fixture(%{icao: "dcba"})
      aircraft_fixture(%{icao: "qwerty", registration_country: "Portugal"})

      assert Aircrafts.list_aircrafts() == [
               {"Portugal", 1},
               {@valid_attrs[:registration_country], 2}
             ]
    end

    test "seen_today/0 returns aircrafts seen today" do
      seen_today = aircraft_fixture(%{icao: "dcba"})

      {:ok, past_date, _} = DateTime.from_iso8601("2018-03-17 21:23:12+0100")
      last_seen = DateTime.truncate(past_date, :second)

      aircraft_fixture(%{last_seen: last_seen})

      assert Aircrafts.seen_today() == [{seen_today.icao, seen_today.registration_country}]
    end

    test "get_aircraft!/1 returns the aircraft with given id" do
      aircraft = aircraft_fixture()
      assert Aircrafts.get_aircraft!(aircraft.icao) == aircraft
    end

    test "create_aircraft/1 with valid data creates a aircraft" do
      assert {:ok, %Aircraft{} = aircraft} = Aircrafts.create_aircraft(@valid_attrs)
    end

    test "create_aircraft/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Aircrafts.create_aircraft(@invalid_attrs)
    end

    test "update_aircraft/2 with valid data updates the aircraft" do
      aircraft = aircraft_fixture()
      assert {:ok, %Aircraft{} = aircraft} = Aircrafts.update_aircraft(aircraft, @update_attrs)
    end

    test "update_aircraft/2 with invalid data returns error changeset" do
      aircraft = aircraft_fixture()
      assert {:error, %Ecto.Changeset{}} = Aircrafts.update_aircraft(aircraft, @invalid_attrs)
      assert aircraft == Aircrafts.get_aircraft!(aircraft.icao)
    end

    test "delete_aircraft/1 deletes the aircraft" do
      aircraft = aircraft_fixture()
      assert {:ok, %Aircraft{}} = Aircrafts.delete_aircraft(aircraft)
      assert_raise Ecto.NoResultsError, fn -> Aircrafts.get_aircraft!(aircraft.icao) end
    end

    test "change_aircraft/1 returns a aircraft changeset" do
      aircraft = aircraft_fixture()
      assert %Ecto.Changeset{} = Aircrafts.change_aircraft(aircraft)
    end
  end
end
