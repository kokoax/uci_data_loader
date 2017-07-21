defmodule Iris do
  require LastUtil

  def load(filename \\ "deps/uci_data_loader/datasets/iris.data")
  def load(filename) do
    {:ok, body} = File.read(filename)

    all_data        = body            |> LastUtil.to_enum(",") |> Enum.filter(&(&1 != [""]))
    target_all_name = all_data        |> Enum.map(&(&1 |> Enum.at(-1)))
    target_names    = target_all_name |> Enum.uniq |> Enum.filter(&(&1 != ""))

    %UCIDataLoader {
      data:            all_data |> data_to_float(4),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:          4,
      amount:          150,
      cluster_num:     target_names |> Enum.count,
      each_amount:     LastUtil.get_each_amount(target_names,target_all_name),
    }
  end

  def data_to_float(data, slice_num) do
    data
    |> Enum.map(&(&1 |> Enum.slice(0,slice_num)))
    |> Enum.map(&(&1 |> LastUtil.to_float))
  end
end

