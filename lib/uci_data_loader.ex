defmodule UCIDataLoader do
  defstruct [:data, :target_all_name, :target_names, :length, :amount, :cluster_num, :each_amount]
  def load_iris do
    Iris.load
  end
  def load_wine_quality do
    WineQuality.load
  end

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

