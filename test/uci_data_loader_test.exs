defmodule UciDataLoaderTest do
  use ExUnit.Case
  doctest UCIDataLoader

  test "data contain nil" do
    iris               = Iris.load("datasets/iris.data")
    wine               = Wine.load("datasets/wine.data")
    wine_quality_red   = WineQuality.load_red("datasets/winequality-red.csv")
    wine_quality_white = WineQuality.load_white("datasets/winequality-white.csv")
    abalone            = Abalone.load("datasets/abalone.data")

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
    wine = WineQuality.load_red("datasets/winequality-red.csv")
    1..1000 |> Enum.map(
      fn(_) ->
        sample = wine |> UCIDataLoader.sampling_with_replace(30)
        assert sample.data |> Enum.all?(&(&1 != [nil]))
        assert sample.data |> Enum.all?(&(&1 != nil))
      end)
  end
end
