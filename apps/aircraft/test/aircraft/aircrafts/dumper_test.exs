defmodule Aircraft.Aircraft.DumperTest do
  use Aircraft.DataCase, async: true

  alias Aircraft.Aircraft.Dumper
  alias Aircraft.Events.Event

  describe "invalid attrs" do
    test "returns :error on nil timestamp" do
      attrs = %{
        "timestamp" => nil
      }

      assert Dumper.call(attrs) == :error
    end

    test "returns :error on string timestamp" do
      attrs = %{
        "timestamp" => "1542652135.7"
      }

      assert Dumper.call(attrs) == :error
    end

    test "returns :error on missing timestamp" do
      attrs = %{
        "foo" => "bar"
      }

      assert Dumper.call(attrs) == :error
    end
  end

  describe "valid attrs" do
    test "creates multiple events" do
      attrs = [
        %{
          "hex" => "700000",
          "timestamp" => 1_542_652_135.7
        },
        %{
          "hex" => "700001",
          "timestamp" => 1_542_652_135.7
        }
      ]

      Dumper.call(attrs)

      event1 = Event |> first |> Repo.one()
      event2 = Event |> last |> Repo.one()

      assert event1.data == List.first(attrs)
      assert event2.data == List.last(attrs)
    end

    test "creates a new event" do
      attrs = %{
        "hex" => "700000",
        "timestamp" => 1_542_652_135.7
      }

      assert {:ok, event} = Dumper.call(attrs)

      last_event = Event |> last |> Repo.one()

      assert last_event.data == attrs
    end
  end
end
