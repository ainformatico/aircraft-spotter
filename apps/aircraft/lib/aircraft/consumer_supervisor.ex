defmodule Aircraft.ConsumerSupervisor do
  @moduledoc """
  Subscribes to Fetcher.Producer and converts each event
  into a async Task.
  """

  @worker_type Aircraft.Consumer.Importer
  @producer_type Fetcher.Producer

  use ConsumerSupervisor

  @doc false
  def start_link(_) do
    ConsumerSupervisor.start_link(__MODULE__, name: __MODULE__)
  end

  @doc false
  def init(_arg) do
    children = [
      %{
        id: @worker_type,
        restart: :transient,
        start: {@worker_type, :start_link, []}
      }
    ]

    opts = [
      strategy: :one_for_one,
      subscribe_to: [{@producer_type, max_demand: 50}]
    ]

    ConsumerSupervisor.init(children, opts)
  end
end
