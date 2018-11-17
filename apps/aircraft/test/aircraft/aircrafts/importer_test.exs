defmodule Aircraft.Aircraft.ImporterTest do
  use Aircraft.DataCase, async: true

  alias Aircraft.Aircraft.Importer
  alias Aircraft.Aircrafts

  describe "invalid attrs" do
    test "returns :error on nil hex" do
      attrs = %{
        "hex" => nil
      }

      assert Importer.handle_aircraft(attrs) == :error
    end

    test "returns :error on missing hex" do
      attrs = %{
        "icao" => "700000"
      }

      assert Importer.handle_aircraft(attrs) == :error
    end
  end

  describe "valid attrs" do
    test "creates multiple aircrafts" do
      attrs = [
        %{
          "hex" => "700000"
        },
        %{"hex" => "700001"}
      ]

      Importer.handle_aircraft(attrs)

      aircraft1 = Aircrafts.get_aircraft!("700000")
      aircraft2 = Aircrafts.get_aircraft!("700001")

      assert aircraft1.icao == "700000"
      assert aircraft2.icao == "700001"
    end

    test "creates a new aircraft" do
      attrs = %{
        "hex" => "700000"
      }

      assert {:ok, _aircraft} = Importer.handle_aircraft(attrs)
      assert Aircrafts.get_aircraft!("700000").icao == attrs["hex"]
    end

    test "update an existing aircraft" do
      {:ok, past_date, _} = DateTime.from_iso8601("2018-03-17 21:23:12+0100")
      now = DateTime.truncate(DateTime.utc_now(), :second)

      aircraft_attrs = %{
        icao: "700000",
        registration_country: "Spain",
        last_seen: past_date
      }

      {:ok, created_aircraft} = Aircrafts.create_aircraft(aircraft_attrs)

      attrs = %{
        "hex" => "700000"
      }

      assert {:ok, _} = Importer.handle_aircraft(attrs, %{category: "helicopter"})

      assert created_aircraft.category == nil

      existing_aircraft = Aircrafts.get_aircraft!(aircraft_attrs[:icao])

      assert existing_aircraft.category == "helicopter"
      assert existing_aircraft.last_seen == now
    end
  end
end
