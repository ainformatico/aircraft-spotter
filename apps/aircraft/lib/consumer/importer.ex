defmodule Aircraft.Consumer.Importer do
  @moduledoc false

  alias Aircraft.Aircraft.Importer

  def start_link(event) do
    Task.start_link(fn ->
      Importer.handle_aircraft(event)
    end)
  end
end
