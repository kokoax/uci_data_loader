defmodule Abalone do
  require FirstUtil

  def load() do
    url = "http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data"
    %HTTPoison.Response{status_code: 200, body: body} = url |> HTTPoison.get!

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

