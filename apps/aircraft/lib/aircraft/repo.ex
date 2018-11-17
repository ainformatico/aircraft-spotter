defmodule Aircraft.Repo do
  use Ecto.Repo,
    otp_app: :aircraft,
    adapter: Ecto.Adapters.Postgres
end
