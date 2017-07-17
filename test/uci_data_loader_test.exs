defmodule UciDataLoaderTest do
  use ExUnit.Case
  doctest UCIDataLoader

  test "data contece nil" do
    iris               = UCIDataLoader.load_iris
    wine               = UCIDataLoader.load_wine
    wine_quality_red   = UCIDataLoader.load_wine_quality_red
    wine_quality_white = UCIDataLoader.load_wine_quality_white
    abalone            = UCIDataLoader.load_abalone

    assert iris.data               |> Enum.all?(&(&1 != nil))
    assert iris.data               |> Enum.all?(&(&1 != ""))
    assert wine.data               |> Enum.all?(&(&1 != nil))
    assert wine.data               |> Enum.all?(&(&1 != ""))
    assert wine_quality_red.data   |> Enum.all?(&(&1 != nil))
    assert wine_quality_red.data   |> Enum.all?(&(&1 != ""))
    assert wine_quality_white.data |> Enum.all?(&(&1 != nil))
    assert wine_quality_white.data |> Enum.all?(&(&1 != ""))
    assert abalone.data            |> Enum.all?(&(&1 != nil))
    assert abalone.data            |> Enum.all?(&(&1 != ""))
  end

  test "sampling has nil? in wine_quality" do
    wine = UCIDataLoader.load_wine_quality_red
    1..1000 |> Enum.map(
      fn(_) ->
        sample = wine |> UCIDataLoader.sampling_with_replace(30)
        assert sample.data |> Enum.all?(&(&1 != [nil]))
        assert sample.data |> Enum.all?(&(&1 != nil))
      end)
  end
end
