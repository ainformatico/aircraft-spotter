defmodule Fetcher.Api do
  @moduledoc """
  Wrapper on top of HTTPoison.
  Intented to be used for testing.
  """

  @doc false
  def get(url), do: HTTPoison.get(url)
end
