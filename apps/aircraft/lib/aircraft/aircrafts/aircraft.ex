defmodule Aircraft.Aircrafts.Aircraft do
  @moduledoc """
  Represents an Aircraft.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:icao, :string, autogenerate: false}

  schema "planes" do
    field(:category, :string)
    field(:registration_country, :string)
    field(:model, :string)
    field(:last_seen, :utc_datetime)

    timestamps()
  end

  @doc false
  @spec changeset(%__MODULE__{}, map()) :: Ecto.Changeset.t()
  def changeset(aircraft, attrs) do
    aircraft
    |> cast(attrs, [:icao, :category, :registration_country, :model, :last_seen, :inserted_at])
    |> validate_required([:icao, :registration_country, :last_seen])
  end
end
