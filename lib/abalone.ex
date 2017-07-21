defmodule Abalone do
  require FirstUtil

  def load(filename \\ "deps/uci_data_loader/datasets/abalone.data")
  def load(filename) do
    {:ok, body} = File.read(filename)

    all_data        = body            |> FirstUtil.to_enum(",") |> Enum.filter(&(&1 != [""]))
    target_all_name = all_data        |> Enum.map(&(&1 |> Enum.at(0)))
    target_names    = target_all_name |> Enum.uniq |> Enum.filter(&(&1 != ""))

    %UCIDataLoader {
      data:            all_data |> FirstUtil.data_to_float(8),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:          8,
      amount:          4177,
      cluster_num:     target_names |> Enum.count,
      each_amount:     FirstUtil.get_each_amount(target_names,target_all_name),
    }
  end
end

