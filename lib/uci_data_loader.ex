defmodule UCIDataLoader do
  defstruct [:data, :target_all_name, :target_names, :length, :amount, :cluster_num, :each_amount]
  @moduledoc """
  UCI module has method that load of data from UCI repository.
  ```
  #iex> UCIDataLoader.load_iris
  #%UCIDataLoader {
  #  data:  [[5.1, 3.5, 1.4, 0.2], [4.9, 3.0, 1.4, 0.2], [4.7, 3.2, 1.3, 0.2], ...],
  #  target_all_name: ["Iris-setosa", "Iris-setosa", "Iris-setosa", "Iris-setosa", ...],
  #  target_names: ["Iris-setosa", "Iris-versicolor", "Iris-virginica"],
  #  length: 4,
  #  amount: 150,
  #  cluster_num: 3,
  #  each_amount: [50, 50, 50],
  #}
  ```
  """
  require FirstUtil

  @doc """
  Data load from iris in UCI repository.

  ### refer
  http://archive.ics.uci.edu/ml/datasets/Iris
  """
  def load_iris do
    Iris.load
  end

  @doc """
  Data load from wine in UCI repository.

  ### refer
  http://archive.ics.uci.edu/ml/datasets/Wine
  """
  def load_wine do
    Wine.load
  end

  @doc """
  Data load from wine quality red in UCI repository.

  ### refer
  http://archive.ics.uci.edu/ml/datasets/Wine+Quality
  """
  def load_wine_quality_red do
    WineQuality.load_red
  end

  @doc """
  Data load from wine quality white in UCI repository.

  ### refer
  http://archive.ics.uci.edu/ml/datasets/Wine+Quality
  """

  def load_wine_quality_white do
    WineQuality.load_white
  end

  @doc """
  Data load from abalone in UCI repository.

  ### refer
  http://archive.ics.uci.edu/ml/datasets/Abalone
  """
  def load_abalone do
    Abalone.load
  end

  @doc """
  This method do n times Sampling with Replacement.
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

    %UCIDataLoader {
      data:            rands |> Enum.map(&(datasets.data |> Enum.at(&1))),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:          datasets.length,
      amount:          n,
      cluster_num:     target_names |> Enum.count,
      each_amount:     FirstUtil.get_each_amount(target_names,target_all_name),
    }
  end
end

