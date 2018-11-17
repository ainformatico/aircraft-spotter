defmodule Fetcher.ProducerTest do
  use ExUnit.Case, async: true
  doctest Fetcher.Producer

  import Mox

  setup :set_mox_global
  setup :verify_on_exit!

  test "calls the worker and the parser" do
    api_response = '{}'
    parser_response = []

    Fetcher.WorkerMock
    |> expect(:call, fn -> api_response end)

    Fetcher.ParserMock
    |> expect(:call, fn '{}' -> parser_response end)

    assert Fetcher.Producer.call() == parser_response
  end
end
