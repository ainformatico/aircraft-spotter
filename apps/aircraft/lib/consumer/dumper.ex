defmodule Aircraft.Consumer.Dumper do
  @moduledoc false

  use GenStage

  alias Aircraft.Aircraft.Dumper

  def start_link(_) do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:consumer, :the_state_does_not_matter, subscribe_to: [Fetcher.Producer]}
  end

  def handle_events(events, _from, state) do
    Enum.each(events, &Dumper.call/1)
    # We are a consumer, so we would never emit items.
    {:noreply, [], state}
  end
end
