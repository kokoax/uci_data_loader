defmodule UCIDataLoader do
  defstruct [:data, :target_all_name, :target_names, :length, :amount, :cluster_num, :each_amount]
  def load_iris do
    iris_url = "http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
    %HTTPoison.Response{status_code: 200, body: body} = iris_url |> HTTPoison.get!

    all_data        = body |> to_enum(",")
    target_all_name = all_data |> to_target_all_name
    target_names    = target_all_name |> Enum.uniq |> Enum.filter(&(&1 != ""))

    %UCIDataLoader{
      data:            all_data |> data_to_float(4),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:   4,
      amount: 150,
      cluster_num:     target_names |> Enum.count,
      each_amount:     get_each_amount(target_names,target_all_name),
    }
  end
  def load_wine do
    wine_url = "http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv"
    %HTTPoison.Response{status_code: 200, body: body} = wine_url |> HTTPoison.get!

    all_data = Regex.split(~r/\R/, body) |> Enum.slice(1,1600-1) |> Enum.join("\n") |> to_enum(";")
    target_all_name = all_data |> to_target_all_name
    target_names    = target_all_name |> Enum.uniq

    %UCIDataLoader{
      data:            all_data |> data_to_float(11),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:     11,
      amount:   1600,
      cluster_num: 6,
      each_amount:     get_each_amount(target_names,target_all_name),
    }
  end

  def data_to_float(data, slice_num) do
    data
    |> Enum.map(&(&1 |> Enum.slice(0,slice_num)))
    |> Enum.map(&(&1 |> to_float))
  end

  def to_enum(body, separator) do
    splited = Regex.split(~r"\R", body)
    splited
    |> Enum.slice(1, (splited |> Enum.count)-3)
    splited |> Enum.map(&(&1 |> String.split(separator)))
  end

  def to_target_all_name(data) do
    data
    |> Enum.map(&(&1 |> Enum.at(-1)))
  end

  def sampling_with_replace(datasets, n) do
    rands = 1..n |> Enum.map(
      fn(_) ->
        :rand.uniform(datasets.amount)-1
      end)

    target_all_name =
      rands
      |> Enum.map(&(datasets.target_all_name |> Enum.at(&1)))
    target_names =
      rands
      |> Enum.map(&(datasets.target_all_name |> Enum.at(&1)))
      |> Enum.uniq

    %UCIDataLoader{
      data:            rands |> Enum.map(&(datasets.data |> Enum.at(&1))),
      target_all_name: target_all_name,
      target_names:    target_names,
      length:   datasets.length,
      amount:   n,
      each_amount:     get_each_amount(target_names,target_all_name),
    }
  end
  defp get_each_amount(target_names, target_all_name) do
    target_names
    |> Enum.map(
      fn(name) ->
        target_all_name
        |> Enum.filter(&(&1 == name))
        |> Enum.count
      end
    )
  end
  defp to_float(data) do
    data |> Enum.map(&(&1 |> Code.eval_string |> elem(0)))
  end
end

