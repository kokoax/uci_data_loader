defmodule ISOLET do
  require LastUtil
  def load(filename \\ "deps/uci_data_loader/datasets/isolet1+2+3+4.data")
  def load(filename) do
    {:ok, body} = File.read(filename)
    all_data        = body            |> LastUtil.to_enum(",") |> Enum.filter(&(&1 != [""]))
    target_all_name = all_data        |> Enum.map(&(&1 |> Enum.at(-1)))
    target_names    = target_all_name |> Enum.uniq |> Enum.filter(&(&1 != ""))

    %UCIDataLoader {
      data:            all_data |> LastUtil.data_to_float(26),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:          26,
      amount:          6238,
      cluster_num:     target_names |> Enum.count,
      each_amount:     LastUtil.get_each_amount(target_names,target_all_name),
    }
  end

  def load_5(filename \\ "deps/uci_data_loader/datasets/isolet5.data")
  def load_5(filename) do
    {:ok, body} = File.read(filename)

    all_data        = body            |> LastUtil.to_enum(",") |> Enum.filter(&(&1 != [""]))
    target_all_name = all_data        |> Enum.map(&(&1 |> Enum.at(-1)))
    target_names    = target_all_name |> Enum.uniq |> Enum.filter(&(&1 != ""))

    %UCIDataLoader {
      data:            all_data |> LastUtil.data_to_float(26),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:          26,
      amount:          1559,
      cluster_num:     target_names |> Enum.count,
      each_amount:     LastUtil.get_each_amount(target_names,target_all_name),
    }
  end
end

