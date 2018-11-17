defmodule AircraftWeb.PageControllerTest do
  use AircraftWeb.ConnCase

  alias Aircraft.Aircrafts

  test "GET /", %{conn: conn} do
    attrs = %{
      icao: "abcd",
      category: "Category",
      registration_country: "Spain",
      model: "A320",
      last_seen: DateTime.utc_now()
    }

    Aircrafts.create_aircraft(attrs)

    conn = get(conn, "/")

    assert html_response(conn, 200) =~ "abcd"
    assert html_response(conn, 200) =~ "Spain"
  end
end
