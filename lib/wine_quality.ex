defmodule WineQuality do
  require Util
  def load_white() do
    wine_url = "http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv"
    %HTTPoison.Response{status_code: 200, body: body} = wine_url |> HTTPoison.get!

    all_data = Regex.split(~r/\R/, body) |> Enum.slice(1,4899-1) |> Enum.join("\n") |> Util.to_enum(";")
    target_all_name = all_data |> Enum.map(&(&1 |> Enum.at(-1)))
    target_names    = target_all_name |> Enum.uniq

    %UCIDataLoader {
      data:            all_data |> Util.data_to_float(11),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:          11,
      amount:          4898,
      cluster_num:     target_names |> Enum.count,
      each_amount:     Util.get_each_amount(target_names,target_all_name),
    }
  end
  def load_red() do
    wine_url = "http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv"
    %HTTPoison.Response{status_code: 200, body: body} = wine_url |> HTTPoison.get!

    all_data = Regex.split(~r/\R/, body) |> Enum.slice(1,1600-1) |> Enum.join("\n") |> Util.to_enum(";")
    target_all_name = all_data |> Enum.map(&(&1 |> Enum.at(-1)))
    target_names    = target_all_name |> Enum.uniq

    %UCIDataLoader {
      data:            all_data |> Util.data_to_float(11),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:          11,
      amount:          1599,
      cluster_num:     target_names |> Enum.count,
      each_amount:     Util.get_each_amount(target_names,target_all_name),
    }
  end
end

