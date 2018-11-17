defmodule AircraftWeb.PageController do
  use AircraftWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html", %{
      aircrafts_seen_today: Aircraft.Aircrafts.seen_today(),
      aircrafts: Aircraft.Aircrafts.list_aircrafts()
    })
  end
end
