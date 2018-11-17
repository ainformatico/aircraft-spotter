defmodule Aircraft.Repo.Migrations.CreateEventsTable do
  use Ecto.Migration

  def change do
    create_if_not_exists table(:events) do
      add(:timestamp, :utc_datetime)
      add(:data, :json)

      # inserted_at and updated_at
      timestamps()
    end
  end
end
