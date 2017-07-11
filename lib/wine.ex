defmodule Wine do
  require Util
  def load() do
    wine_url = "http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data"
    %HTTPoison.Response{status_code: 200, body: body} = wine_url |> HTTPoison.get!

    all_data = Regex.split(~r/\R/, body) |> Enum.join("\n") |> Util.to_enum(",")
    target_all_name = all_data |> Enum.map(&(&1 |> Enum.at(0)))
    target_names    = target_all_name |> Enum.uniq

    %UCIDataLoader {
      data:            all_data |> Util.data_to_float(13),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:          13,
      amount:          177,
      cluster_num:     target_names |> Enum.count,
      each_amount:     Util.get_each_amount(target_names,target_all_name),
    }
  end
end

