defmodule Wine do
  require FirstUtil
  def load() do
    wine_url = "http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data"
    %HTTPoison.Response{status_code: 200, body: body} = wine_url |> HTTPoison.get!

    all_data =
      Regex.split(~r/\R/, body |> String.replace(",.", ",0."))
      |> Enum.join("\n")
      |> FirstUtil.to_enum(",")
      |> Enum.filter(&(&1 != [""]))
    target_all_name = all_data |> Enum.map(&(&1 |> Enum.at(0)))
    target_names    = target_all_name |> Enum.uniq

    %UCIDataLoader {
      data:            all_data |> FirstUtil.data_to_float(13),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:          13,
      amount:          178,
      cluster_num:     target_names |> Enum.count,
      each_amount:     FirstUtil.get_each_amount(target_names,target_all_name),
    }
  end
end

