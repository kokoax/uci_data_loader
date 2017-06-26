defmodule UciDataLoaderTest do
  use ExUnit.Case
  doctest UCIDataLoader

  test "sampling has nil? in wine_quality" do
    wine = UCIDataLoader.load_wine_quality
    1..1000 |> Enum.map(
      fn(_) ->
        sample = wine |> UCIDataLoader.sampling_with_replace(30)
        assert sample.data |> Enum.all?(&(&1 != [nil]))
        assert sample.data |> Enum.all?(&(&1 != nil))
      end)
  end
end
