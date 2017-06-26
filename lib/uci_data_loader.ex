defmodule UCIDataLoader do
  defstruct [:data, :target_all_name, :target_names, :length, :amount, :cluster_num, :each_amount]

  @moduledoc """
  UCI module has method that load of data from UCI repository.
  ```
  iex> UCIDataLoader.load_iris
  %UCIDataLoader {
    data:  [[5.1, 3.5, 1.4, 0.2], [4.9, 3.0, 1.4, 0.2], [4.7, 3.2, 1.3, 0.2], ...],
    target_all_name: ["Iris-setosa", "Iris-setosa", "Iris-setosa", "Iris-setosa", ...],
    target_names: ["Iris-setosa", "Iris-versicolor", "Iris-virginica"],
    length: 4,
    amount: 150,
    cluster_num: 3,
    each_amount: [50, 50, 50],
  }
  ```
  """

  @doc """
  Data load from iris in UCI repository.

  ### refer
  http://archive.ics.uci.edu/ml/datasets/Iris
  """
  def load_iris do
    Iris.load
  end

  @doc """
  Data load from wine quality in UCI repository.

  ### refer
  http://archive.ics.uci.edu/ml/datasets/Wine+Quality
  """
  def load_wine_quality do
    WineQuality.load
  end

  @doc """
  This method do number of n Sampling with Replacement.
  """
  def sampling_with_replace(datasets, n) do
    rands = 1..n |> Enum.map(
      fn(_) ->
        :rand.uniform(datasets.amount)-1
      end)

    target_all_name =
      rands
      |> Enum.map(&(datasets.target_all_name |> Enum.at(&1)))
    target_names =
      rands
      |> Enum.map(&(datasets.target_all_name |> Enum.at(&1)))
      |> Enum.uniq

    %UCIDataLoader{
      data:            rands |> Enum.map(&(datasets.data |> Enum.at(&1))),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:          datasets.length,
      amount:          n,
      cluster_num:     target_names |> Enum.count,
      each_amount:     Util.get_each_amount(target_names,target_all_name),
    }
  end
end

