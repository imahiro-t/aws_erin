defmodule AwsErin.DynamoDB.Value do
  def to_map(value) when value |> is_nil, do: %{"NULL" => true}
  def to_map(value) when value |> is_boolean, do: %{"BOOL" => value}
  def to_map(value) when value |> is_number, do: %{"N" => value |> to_string}
  def to_map(value) when value |> is_binary, do: %{"S" => value}
  def to_map(value) when value |> is_map, do: %{"M" => value}
  def to_map(value) when value |> is_list do
    cond do
      value |> Enum.all?(&is_binary/1) -> %{"SS" => value}
      value |> Enum.all?(&is_number/1) -> %{"NS" => value |> Enum.map(&to_string/1)}
      true -> %{"L" => value}
    end
  end

  def from_map(%{"NULL" => true}), do: nil
  def from_map(%{"BOOL" => value}), do: value
  def from_map(%{"N" => value}), do: value |> to_number
  def from_map(%{"S" => value}), do: value
  def from_map(%{"M" => value}), do: value
  def from_map(%{"SS" => value}), do: value
  def from_map(%{"NS" => value}), do: value |> Enum.map(&to_number/1)
  def from_map(%{"L" => value}), do: value

  defp to_number(value) do
    case value |> Integer.parse do
      {i, ""} -> i
      _ -> value |> String.to_float
    end
  end
end
