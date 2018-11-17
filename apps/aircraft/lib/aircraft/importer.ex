defmodule Aircraft.Aircraft.Importer do
  @moduledoc """
  Imports or aggregates the data for an Aircraft.
  """

  @doc false
  def handle_aircraft(aircraft) when is_list(aircraft) do
    Enum.map(aircraft, &handle_aircraft/1)
  end

  def handle_aircraft(%{"hex" => nil}), do: :error

  @doc """
  Imports or aggregates the data.
  """
  @spec handle_aircraft([map()] | map() | [map()], map()) ::
          Ecto.Changeset.t() | [Ecto.Changeset.t()] | :error
  def handle_aircraft(aircraft, opts \\ %{}) do
    with {:ok, hex} <- Map.fetch(aircraft, "hex"),
         attrs <-
           Map.merge(
             %{icao: hex, registration_country: decode_country(hex), last_seen: last_seen()},
             opts
           ),
         resource <- Aircraft.Aircrafts.find_or_create(hex, attrs) do
      Aircraft.Aircrafts.insert_or_update(resource, attrs)
    else
      _ -> :error
    end
  end

  defp decode_country(icao) do
    Decoder.ICAO.decode(icao)[:country]
  end

  defp last_seen do
    DateTime.truncate(DateTime.utc_now(), :second)
  end
end
