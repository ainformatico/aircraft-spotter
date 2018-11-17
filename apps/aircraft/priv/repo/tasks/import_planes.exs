defmodule Aircraft.Tasks.ImportPlanes do
  @moduledoc false

  import Ecto.Query

  def call do
    Enum.each(Aircraft.Repo.all(Aircraft.RawAircraft), fn aircraft ->
      aircraft = {aircraft.hex, aircraft.timestamp, aircraft.data}

      aircraft
      |> handle_aircraft
    end)
  end

  defp handle_aircraft(aircraft) do
    {_, timestamp, json} = aircraft
    opts = %{last_seen: timestamp, inserted_at: timestamp}

    Aircraft.AircraftImporter.handle_aircraft(json, opts)
  end
end

Aircraft.Tasks.ImportPlanes.call()
