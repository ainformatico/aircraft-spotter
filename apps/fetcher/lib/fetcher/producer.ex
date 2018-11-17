defmodule Fetcher.Producer do
  @moduledoc """
  GenStage producer that fetches data from the remote API.
  """

  @interval_in_ms 1_000

  @worker Application.get_env(:fetcher, :worker)
  @parser Application.get_env(:fetcher, :parser)

  use GenStage

  @doc false
  def start_link(state \\ %{}) do
    GenStage.start_link(__MODULE__, state, name: __MODULE__)
  end

  @doc false
  def init(state) do
    schedule()

    {:producer, state, dispatcher: GenStage.BroadcastDispatcher}
  end

  @doc """
  Callback to handle adding events to the _queue_ asynchronously.
  """
  def handle_cast({:add, events}, state) do
    {:noreply, events, state}
  end

  @doc """
  Callback to request new data and schedule the next call.
  """
  def handle_info(:run, state) do
    GenServer.cast(__MODULE__, {:add, call()})

    schedule()

    {:noreply, [], state}
  end

  @doc """
  We will send the demand as soon as it arrives so for now
  we tell our consumers there's nothing to do.
  """
  def handle_demand(_, state), do: {:noreply, [], state}

  @doc """
  Fetches and parses data.
  """
  @spec call() :: [map()]
  def call do
    @worker.call() |> @parser.call()
  end

  defp schedule do
    if Application.get_env(:fetcher, :schedule) do
      Process.send_after(self(), :run, @interval_in_ms)
    end
  end
end
