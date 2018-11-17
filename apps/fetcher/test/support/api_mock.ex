defmodule Fetcher.ApiMock do
  @moduledoc false

  @doc false
  def get("/data.json") do
    {:ok, %HTTPoison.Response{status_code: 200, body: "body"}}
  end

  @doc false
  def get("/error") do
    {:error, %HTTPoison.Error{reason: "error"}}
  end
end
