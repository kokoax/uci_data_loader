defmodule Iris do
  require Util
  def load() do
    iris_url = "http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
    %HTTPoison.Response{status_code: 200, body: body} = iris_url |> HTTPoison.get!

    all_data        = body            |> Util.to_enum(",") |> Enum.filter(&(&1 != [""]))
    target_all_name = all_data        |> Enum.map(&(&1 |> Enum.at(-1)))
    target_names    = target_all_name |> Enum.uniq |> Enum.filter(&(&1 != ""))

    %UCIDataLoader {
      data:            all_data |> data_to_float(4),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:          4,
      amount:          150,
      cluster_num:     target_names |> Enum.count,
      each_amount:     Util.get_each_amount(target_names,target_all_name),
    }
  end

  def data_to_float(data, slice_num) do
    data
    |> Enum.map(&(&1 |> Enum.slice(0,slice_num)))
    |> Enum.map(&(&1 |> to_float))
  end
end

