defmodule AwsErin.DynamoDB.Common do
  alias AwsErin.DynamoDB.Value
  alias AwsErin.DynamoDB.Common.StructList
  alias AwsErin.DynamoDB.Common.StructMap
  alias AwsErin.DynamoDB.Common.Key
  alias AwsErin.DynamoDB.Common.RequestItem
  alias AwsErin.DynamoDB.Common.UnprocessedKey
  alias AwsErin.DynamoDB.Common.ConsumedCapacity
  alias AwsErin.DynamoDB.Common.SecondaryIndex
  alias AwsErin.DynamoDB.Common.Table

  defmodule StructList do
    def to_map(nil, _struct), do: nil
    def to_map(list, struct) when list |> is_list, do: list |> Enum.map(&struct.to_map/1)
    def to_struct(nil, _struct), do: nil
    def to_struct(list, struct) when list |> is_list, do: list |> Enum.map(&struct.to_struct/1)
  end
  defmodule StructMap do
    def to_map(nil, _struct), do: nil
    def to_map(list, struct) when list |> is_list, do: list |> Enum.reduce(%{}, fn x, acc -> acc |> Map.merge(x |> struct.to_map) end)
    def to_struct(nil, _struct), do: nil
    def to_struct(map, struct) when map |> is_map, do: map |> Enum.map(fn {key, value} -> %{key => value} |> struct.to_struct end)
  end
  defmodule Key do
    defstruct [
      :name,
      :value
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{struct.name => struct.value |> Value.to_map}
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      %Key{
        name: map |> Map.keys |> List.first,
        value: map |> Map.values |> List.first |> Value.from_map
      }
    end
  end
  defmodule RequestItem do
    defstruct [
      :name,
      :expression_attribute_names,
      :keys,
      :projection_expression,
      consistent_read: false
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{struct.name => %{
        "ExpressionAttributeNames" => struct.expression_attribute_names,
        "Keys" => struct.keys |> StructList.to_map(Key),
        "ProjectionExpression" => struct.projection_expression,
        "ConsistentRead" => struct.consistent_read
      }}
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      value = map |> Map.values |> List.first
      %RequestItem{
        name: map |> Map.keys |> List.first,
        expression_attribute_names: value |> Map.get("ExpressionAttributeNames"),
        keys: value |> Map.get("Keys") |> StructList.to_struct(Key),
        projection_expression: value |> Map.get("ProjectionExpression"),
        consistent_read: value |> Map.get("ConsistentRead")
      }
    end
  end
  defmodule ConsumedCapacity do
    defstruct [
      :capacity_units,
      :global_secondary_indexes,
      :local_secondary_indexes,
      :read_capacity_units,
      :table,
      :table_name,
      :write_capacity_units
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{
        "CapacityUnits" => struct.capacity_units,
        "GlobalSecondaryIndexes" => struct.global_secondary_indexes |> StructMap.to_map(SecondaryIndex),
        "LocalSecondaryIndexes" => struct.local_secondary_indexes |> StructMap.to_map(SecondaryIndex),
        "ReadCapacityUnits" => struct.read_capacity_units,
        "Table" => struct.table |> Table.to_map,
        "TableName" => struct.table_name,
        "WriteCapacityUnits" => struct.write_capacity_units
      }
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      %ConsumedCapacity{
        capacity_units: map |> Map.get("CapacityUnits"),
        global_secondary_indexes: map |> Map.get("GlobalSecondaryIndexes") |> StructMap.to_struct(SecondaryIndex),
        local_secondary_indexes: map |> Map.get("LocalSecondaryIndexes") |> StructMap.to_struct(SecondaryIndex),
        read_capacity_units: map |> Map.get("ReadCapacityUnits"),
        table: map |> Map.get("Table") |> Table.to_struct,
        table_name: map |> Map.get("TableName"),
        write_capacity_units: map |> Map.get("WriteCapacityUnits"),
      }
    end
  end
  defmodule SecondaryIndex do
    defstruct [
      :name,
      :capacity_units,
      :read_capacity_units,
      :write_capacity_units
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{struct.name => %{
        "CapacityUnits" => struct.capacity_units,
        "ReadCapacityUnits" => struct.read_capacity_units,
        "WriteCapacityUnits" => struct.write_capacity_units
      }}
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      value = map |> Map.values |> List.first
      %SecondaryIndex{
        name: map |> Map.keys |> List.first,
        capacity_units: value |> Map.get("CapacityUnits"),
        read_capacity_units: value |> Map.get("ReadCapacityUnits"),
        write_capacity_units: value |> Map.get("WriteCapacityUnits"),
      }
    end
  end
  defmodule Table do
    defstruct [
      :capacity_units,
      :read_capacity_units,
      :write_capacity_units
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{
        "CapacityUnits" => struct.capacity_units,
        "ReadCapacityUnits" => struct.read_capacity_units,
        "WriteCapacityUnits" => struct.write_capacity_units
      }
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      %Table{
        capacity_units: map |> Map.get("CapacityUnits"),
        read_capacity_units: map |> Map.get("ReadCapacityUnits"),
        write_capacity_units: map |> Map.get("WriteCapacityUnits"),
      }
    end
  end
  defmodule Response do
    defstruct [
      :name,
      :values
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{struct.name => struct.values |> Enum.map(&(&1 |> StructMap.to_map(Key)))}
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      %Response{
        name: map |> Map.keys |> List.first,
        values: map |> Map.values |> List.first |> Enum.map(&(&1 |> StructMap.to_struct(Key)))
      }
    end
  end
  defmodule UnprocessedKey do
    defstruct [
      :name,
      :expression_attribute_names,
      :keys,
      :projection_expression,
      consistent_read: false
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{struct.name => %{
        "ExpressionAttributeNames" => struct.expression_attribute_names,
        "Keys" => struct.keys |> StructList.to_map(Key),
        "ProjectionExpression" => struct.projection_expression,
        "ConsistentRead" => struct.consistent_read
      }}
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      value = map |> Map.values |> List.first
      %UnprocessedKey{
        name: map |> Map.keys |> List.first,
        expression_attribute_names: value |> Map.get("ExpressionAttributeNames"),
        keys: value |> Map.get("Keys") |> StructList.to_struct(Key),
        projection_expression: value |> Map.get("ProjectionExpression"),
        consistent_read: value |> Map.get("ConsistentRead")
      }
    end
  end
end
