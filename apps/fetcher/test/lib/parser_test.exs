defmodule Fetcher.ParserTest do
  use ExUnit.Case, async: true
  doctest Fetcher.Parser

  describe "when valid data" do
    setup do
      {:ok, expected_result: [%{"flight" => "abcdef", "timestamp" => "1234"}]}
    end

    test "encodes and decorates the data", %{expected_result: expected_result} do
      json = '{\"now\": \"1234\", \"aircraft\": [{\"flight\": \"abcdef\"}]}'

      assert Fetcher.Parser.call(json) == expected_result
    end

    test "trims whitespaces", %{expected_result: expected_result} do
      json = '{\"now\": \"1234\", \"aircraft\": [{\"flight\": \"abcdef   \"}]}'

      assert Fetcher.Parser.call(json) == expected_result
    end

    test "timestamp is null" do
      json = '{\"aircraft\": [{\"flight\": \"abcdef   \"}]}'
      expected_result = [%{"flight" => "abcdef", "timestamp" => nil}]

      assert Fetcher.Parser.call(json) == expected_result
    end

    test "aircraft is empty" do
      json = '{\"now\": \"1234\", \"aircraft\": []}'

      assert Fetcher.Parser.call(json) == []
    end

    test "flight is empty" do
      json = '{\"now\": \"1234\", \"aircraft\": [{\"category\": \"Helicopter\"}]}'

      assert Fetcher.Parser.call(json) == [%{"category" => "Helicopter", "timestamp" => "1234"}]
    end

    test "all is empty" do
      assert Fetcher.Parser.call('{}') == []
    end
  end

  describe "when invalid data" do
    test "invalid json raises error" do
      assert_raise(Jason.DecodeError, fn ->
        Fetcher.Parser.call('abcd')
      end)
    end

    test "nil raises error" do
      assert_raise(ArgumentError, fn ->
        Fetcher.Parser.call(nil)
      end)
    end
  end
end
