defmodule Fetcher.Worker do
  @moduledoc """
  Fetch json data from a dump1090-fa server.
  """

  @callback call() :: String.t()
  @callback call(String.t()) :: String.t()

  @api Application.get_env(:fetcher, :api)

  require Logger

  @doc """
  Requests data from the remote sever.

  ## Examples

      iex> Fetcher.Worker.call()
      "body"
  """
  @spec call(String.t()) :: String.t()
  @spec call() :: String.t()
  def call(url \\ url()) do
    case @api.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error(reason)

        {:error}
    end
  end

  defp url do
    Application.get_env(:fetcher, :dump1090_json_endpoint)
  end
end
