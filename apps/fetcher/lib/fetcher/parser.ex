defmodule Fetcher.Parser do
  @moduledoc """
  Parses and decorates data from a dump1090-fa json
  """

  @callback call(String.t()) :: map()

  @doc """
  Parses the given JSON(string) into a map and decorates the data.

  ## Examples

      iex> Fetcher.Parser.call('{\"now\": \"1234\", \"aircraft\": [{\"flight\": \"abcdef\"}]}')
      [%{"flight" => "abcdef", "timestamp" => "1234"}]
  """
  @spec call(String.t()) :: [map()]
  def call(data) do
    json = Jason.decode!(data)

    json
    |> Map.get("aircraft", %{})
    |> Stream.map(&add_timestamp(&1, json["now"]))
    |> Stream.map(&trim_whitespaces/1)
    |> Enum.to_list()
  end

  defp add_timestamp(item, timestamp) do
    Map.put(item, "timestamp", timestamp)
  end

  defp trim_whitespaces(item) do
    case Map.get_and_update(item, "flight", fn v -> {v, String.trim(v || "")} end) do
      {nil, _} -> item
      {_, result} -> result
    end
  end
end
