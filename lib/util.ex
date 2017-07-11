defmodule LastUtil do
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

  def get_each_amount(target_names, target_all_name) do
    target_names
    |> Enum.map(
      fn(name) ->
        target_all_name
        |> Enum.filter(&(&1 == name))
        |> Enum.count
      end
    )
  end

  def to_float(data) do
    data |> Enum.map(&(&1 |> Code.eval_string |> elem(0)))
  end
end

defmodule FirstUtil do
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

  def get_each_amount(target_names, target_all_name) do
    target_names
    |> Enum.map(
      fn(name) ->
        target_all_name
        |> Enum.filter(&(&1 == name))
        |> Enum.count
      end
    )
  end

  def to_float(data) do
    data |> Enum.map(&(&1 |> Code.eval_string |> elem(0)))
  end
end

