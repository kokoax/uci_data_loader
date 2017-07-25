defmodule Sonar do
  require LastUtil
  def load(filename \\ "deps/uci_data_loader/datasets/sonar.all-data")
  def load(filename) do
    {:ok, body} = File.read(filename)

    all_data        = body            |> LastUtil.to_enum(",") |> Enum.filter(&(&1 != [""]))
    target_all_name = all_data        |> Enum.map(&(&1 |> Enum.at(-1)))
    target_names    = target_all_name |> Enum.uniq |> Enum.filter(&(&1 != ""))

    %UCIDataLoader {
      data:            all_data |> LastUtil.data_to_float(60),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:          59,
      amount:          208,
      cluster_num:     target_names |> Enum.count,
      each_amount:     LastUtil.get_each_amount(target_names,target_all_name),
    }
  end
end

