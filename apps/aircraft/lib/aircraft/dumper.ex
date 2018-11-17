defmodule Aircraft.Aircraft.Dumper do
  @moduledoc """
  Dumps data into the database.
  This module is intended to store the events for our EventSource.
  """

  alias Aircraft.Events

  @doc false
  def call(aircraft) when is_list(aircraft) do
    Enum.map(aircraft, &call/1)
  end

  @doc """
  Stores the data in the database.
  """
  @spec call(map() | [map()]) :: Ecto.Changeset.t() | [Ecto.Changeset.t()] | :error
  def call(aircraft) do
    with {:ok, timestamp} <- Map.fetch(aircraft, "timestamp"),
         true <- is_float(timestamp),
         timestamp <- timestamp |> trunc |> DateTime.from_unix!() do
      Events.create_event(%{timestamp: timestamp, data: aircraft})
    else
      _ -> :error
    end
  end
end
