defmodule Fetcher.WorkerTest do
  use ExUnit.Case, async: true
  doctest Fetcher.Worker

  describe "when valid request" do
    test "returns the request body" do
      assert Fetcher.Worker.call() == "body"
    end
  end

  @moduletag :capture_log
  describe "when invalid request" do
    test "returns empty" do
      assert Fetcher.Worker.call("/error") == {:error}
    end
  end
end
