defmodule WineQuality do
  require LastUtil

  def load_white(filename \\ "deps/uci_data_loader/datasets/winequality-white.csv")
  def load_white(filename) do
    load(filename, 4899)
  end

  def load_red(filename \\ "deps/uci_data_loader/datasets/winequality-red.csv")
  def load_red(filename) do
    load(filename, 1600)
  end

  def load(filename, amount) do
    {:ok, body} = File.read(filename)

    all_data = Regex.split(~r/\R/, body) |> Enum.slice(1,amount-1) |> Enum.join("\n") |> LastUtil.to_enum(";")
    target_all_name = all_data |> Enum.map(&(&1 |> Enum.at(-1)))
    target_names    = target_all_name |> Enum.uniq

    %UCIDataLoader {
      data:            all_data |> LastUtil.data_to_float(11),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:          11,
      amount:          amount-1,
      cluster_num:     target_names |> Enum.count,
      each_amount:     LastUtil.get_each_amount(target_names,target_all_name),
    }
  end
end

