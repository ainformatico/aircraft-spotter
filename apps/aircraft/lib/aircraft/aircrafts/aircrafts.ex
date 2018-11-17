defmodule Aircraft.Aircrafts do
  @moduledoc """
  The Aircrafts context.
  """

  import Ecto.Query, warn: false
  alias Aircraft.Repo

  alias Aircraft.Aircrafts.Aircraft

  @doc """
  Finds or create an Aircraft.

  ## Examples

      iex> find_or_create("abcd", %{})
      [%Aircraft{}, ...]

  """
  @spec find_or_create(String.t(), map()) :: %Aircraft{} | Ecto.Changeset.t()
  def find_or_create(icao, attrs) do
    case Repo.get(Aircraft, icao) do
      nil -> Map.merge(%Aircraft{}, attrs)
      plane -> plane
    end
  end

  @doc """
  Inserts or update a record.

  ## Examples

      iex> insert_or_update(%Aircraft{}, %{})
      [%Aircraft{}, ...]

  """
  @spec insert_or_update(%Aircraft{}, map()) :: Ecto.Changeset.t()
  def insert_or_update(resource, attrs) do
    resource
    |> Aircraft.changeset(attrs)
    |> Repo.insert_or_update()
  end

  @doc """
  Returns the list of aircrafts seen today.

  ## Examples

      iex> seen_today()
      [%Aircraft{}, ...]

  """
  def seen_today do
    today = Timex.beginning_of_day(Timex.now())

    query =
      from(p in Aircraft,
        select: {p.icao, p.registration_country},
        where: p.last_seen > ^today,
        order_by: :registration_country
      )

    Repo.all(query)
  end

  @doc """
  Returns the list of aircrafts.

  ## Examples

      iex> list_aircrafts()
      [{"Spain", 2}, {"Portugal", 1}]

  """
  def list_aircrafts do
    query =
      from(p in Aircraft,
        select: {p.registration_country, count(p.registration_country)},
        group_by: :registration_country,
        order_by: :registration_country
      )

    Repo.all(query)
  end

  @doc """
  Gets a single aircraft.

  Raises `Ecto.NoResultsError` if the Aircraft does not exist.

  ## Examples

      iex> get_aircraft!(123)
      %Aircraft{}

      iex> get_aircraft!(456)
      ** (Ecto.NoResultsError)

  """
  def get_aircraft!(id), do: Repo.get!(Aircraft, id)

  @doc """
  Creates a aircraft.

  ## Examples

      iex> create_aircraft(%{field: value})
      {:ok, %Aircraft{}}

      iex> create_aircraft(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_aircraft(attrs) do
    %Aircraft{}
    |> Aircraft.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a aircraft.

  ## Examples

      iex> update_aircraft(aircraft, %{field: new_value})
      {:ok, %Aircraft{}}

      iex> update_aircraft(aircraft, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_aircraft(%Aircraft{} = aircraft, attrs) do
    aircraft
    |> Aircraft.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Aircraft.

  ## Examples

      iex> delete_aircraft(aircraft)
      {:ok, %Aircraft{}}

      iex> delete_aircraft(aircraft)
      {:error, %Ecto.Changeset{}}

  """
  def delete_aircraft(%Aircraft{} = aircraft) do
    Repo.delete(aircraft)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking aircraft changes.

  ## Examples

      iex> change_aircraft(aircraft)
      %Ecto.Changeset{source: %Aircraft{}}

  """
  def change_aircraft(%Aircraft{} = aircraft) do
    Aircraft.changeset(aircraft, %{})
  end
end
