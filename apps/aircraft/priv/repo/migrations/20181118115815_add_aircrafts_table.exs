defmodule Aircraft.Repo.Migrations.AddAircraftsTable do
  use Ecto.Migration

  def change do
    create_if_not_exists table(:planes, primary_key: false) do
      add(:icao, :string, primary_key: true, unique: true)
      add(:category, :string)
      add(:registration_country, :string)
      add(:model, :string)
      add(:registration, :string)
      add(:last_seen, :utc_datetime)

      # inserted_at and updated_at
      timestamps()
    end
  end
end
