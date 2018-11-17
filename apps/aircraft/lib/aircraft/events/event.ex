defmodule Aircraft.Events.Event do
  @moduledoc """
  Represents the Event of the spotted aircraft.
  This includes @data as the raw JSON from the source.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field(:timestamp, :utc_datetime)
    field(:data, :map)

    timestamps()
  end

  @doc false
  @spec changeset(%__MODULE__{}, map()) :: Ecto.Changeset.t()
  def changeset(aircraft, attrs) do
    aircraft
    |> cast(attrs, [:timestamp, :data])
    |> validate_required([:timestamp, :data])
  end
end
