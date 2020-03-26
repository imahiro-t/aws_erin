defmodule AwsErin.DynamoDB.Common do
  alias AwsErin.DynamoDB.Common.AttributeValue
  alias AwsErin.DynamoDB.Common.StructList
  alias AwsErin.DynamoDB.Common.StructMap
  alias AwsErin.DynamoDB.Common.AttributeUtil
  alias AwsErin.DynamoDB.Common.Key
  alias AwsErin.DynamoDB.Common.Item
  alias AwsErin.DynamoDB.Common.Attribute
  alias AwsErin.DynamoDB.Common.RequestItem
  alias AwsErin.DynamoDB.Common.RequestWriteItems
  alias AwsErin.DynamoDB.Common.RequestWriteItem
  alias AwsErin.DynamoDB.Common.UnprocessedItems
  alias AwsErin.DynamoDB.Common.UnprocessedItem
  alias AwsErin.DynamoDB.Common.DeleteRequest
  alias AwsErin.DynamoDB.Common.PutRequest
  alias AwsErin.DynamoDB.Common.ConsumedCapacity
  alias AwsErin.DynamoDB.Common.Capacity
  alias AwsErin.DynamoDB.Common.Table
  alias AwsErin.DynamoDB.Common.UnprocessedKey
  alias AwsErin.DynamoDB.Common.ExpressionAttributeName
  alias AwsErin.DynamoDB.Common.ItemCollectionMetrics

  defmodule AttributeValue do
    def to(value, blob: true) when value |> is_binary, do: %{"B" => value}
    def to(value, blob: true) when value |> is_list do
      cond do
        value |> Enum.all?(&is_binary/1) -> %{"BS" => value}
      end
    end
    def to(value) when value |> is_nil, do: %{"NULL" => true}
    def to(value) when value |> is_boolean, do: %{"BOOL" => value}
    def to(value) when value |> is_number, do: %{"N" => value |> to_string}
    def to(value) when value |> is_binary, do: %{"S" => value}
    def to(value) when value |> is_map, do: %{"M" => value |> Enum.reduce(%{}, fn {key, value}, acc -> acc |> Map.merge(%{key => value |> AttributeValue.to}) end)}
    def to(value) when value |> is_list do
      cond do
        value |> Enum.all?(&is_binary/1) -> %{"SS" => value}
        value |> Enum.all?(&is_number/1) -> %{"NS" => value |> Enum.map(&to_string/1)}
        true -> %{"L" => value |> Enum.map(&AttributeValue.to/1)}
      end
    end
    def from(%{"NULL" => true}), do: nil
    def from(%{"BOOL" => value}), do: value
    def from(%{"N" => value}), do: value |> to_number
    def from(%{"S" => value}), do: value
    def from(%{"B" => value}), do: value
    def from(%{"M" => value}), do: value |> Enum.reduce(%{}, fn {key, value}, acc -> acc |> Map.merge(%{key => value |> AttributeValue.from}) end)
    def from(%{"SS" => value}), do: value
    def from(%{"BS" => value}), do: value
    def from(%{"NS" => value}), do: value |> Enum.map(&to_number/1)
    def from(%{"L" => value}), do: value |> Enum.map(&AttributeValue.from/1)
    defp to_number(value) do
      case value |> Integer.parse do
        {i, ""} -> i
        _ -> value |> String.to_float
      end
    end
  end
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
  defmodule AttributeUtil do
    def to_map(nil), do: nil
    def to_map(list) when list |> is_list, do: list |> Enum.reduce(%{}, fn x, acc -> acc |> Map.merge(%{x.name => x.value}) end)
    def to_list(nil, _struct), do: nil
    def to_list(map, struct) when map |> is_map, do: map |> Enum.map(fn {key, value} -> struct(struct, %{name: key, value: value}) end)
  end

  defmodule Key do
    defstruct [
      :name,
      :value,
      :options
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      if (struct.options |> is_nil) do
        %{struct.name => struct.value |> AttributeValue.to}
      else
        %{struct.name => struct.value |> AttributeValue.to(struct.options)}
      end
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      %Key{
        name: map |> Map.keys |> List.first,
        value: map |> Map.values |> List.first |> AttributeValue.from
      }
    end
  end
  defmodule Item do
    defstruct [
      :name,
      :value
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{struct.name => struct.value |> AttributeValue.to}
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      %Item{
        name: map |> Map.keys |> List.first,
        value: map |> Map.values |> List.first |> AttributeValue.from
      }
    end
  end
  defmodule Attribute do
    defstruct [
      :name,
      :value
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{struct.name => struct.value |> AttributeValue.to}
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      %Attribute{
        name: map |> Map.keys |> List.first,
        value: map |> Map.values |> List.first |> AttributeValue.from
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
        "Keys" => struct.keys |> Enum.map(&(&1 |> StructMap.to_map(Key))),
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
        keys: value |> Map.get("Keys") |> Enum.map(&(&1 |> StructMap.to_struct(Key))),
        projection_expression: value |> Map.get("ProjectionExpression"),
        consistent_read: value |> Map.get("ConsistentRead")
      }
    end
  end
  defmodule RequestWriteItems do
    defstruct [
      :name,
      :values
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{struct.name => struct.values |> Enum.map(&(&1 |> StructMap.to_map(RequestWriteItem)))}
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      %RequestWriteItems{
        name: map |> Map.keys |> List.first,
        values: map |> Map.values |> List.first |> Enum.map(&(&1 |> StructMap.to_struct(RequestWriteItem)))
      }
    end
  end
  defmodule RequestWriteItem do
    defstruct [
      :delete_request,
      :put_request
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{
        "DeleteRequest" => struct.delete_request |> DeleteRequest.to_map,
        "PutRequest" => struct.put_request |> PutRequest.to_map
      }
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      %RequestWriteItem{
        delete_request: map |> Map.get("DeleteRequest") |> DeleteRequest.to_struct,
        put_request: map |> Map.get("PutRequest") |> PutRequest.to_struct
      }
    end
  end
  defmodule UnprocessedItems do
    defstruct [
      :name,
      :values
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{struct.name => struct.values |> Enum.map(&(&1 |> StructMap.to_map(UnprocessedItem)))}
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      %UnprocessedItems{
        name: map |> Map.keys |> List.first,
        values: map |> Map.values |> List.first |> Enum.map(&(&1 |> StructMap.to_struct(UnprocessedItem)))
      }
    end
  end
  defmodule UnprocessedItem do
    defstruct [
      :delete_request,
      :put_request
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{
        "DeleteRequest" => struct.delete_request |> DeleteRequest.to_map,
        "PutRequest" => struct.put_request |> PutRequest.to_map
      }
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      %UnprocessedItem{
        delete_request: map |> Map.get("DeleteRequest") |> DeleteRequest.to_struct,
        put_request: map |> Map.get("PutRequest") |> PutRequest.to_struct
      }
    end
  end
  defmodule DeleteRequest do
    defstruct [
      :key
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{
        "Key" => struct.key |> StructMap.to_map(Key)
      }
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      %DeleteRequest{
        key: map |> Map.get("Key") |> StructMap.to_struct(Key)
      }
    end
  end
  defmodule PutRequest do
    defstruct [
      :item
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{
        "Item" => struct.item |> StructMap.to_map(Item)
      }
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      %PutRequest{
        item: map |> Map.get("Item") |> StructMap.to_struct(Item)
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
        "GlobalSecondaryIndexes" => struct.global_secondary_indexes |> StructMap.to_map(Capacity),
        "LocalSecondaryIndexes" => struct.local_secondary_indexes |> StructMap.to_map(Capacity),
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
        global_secondary_indexes: map |> Map.get("GlobalSecondaryIndexes") |> StructMap.to_struct(Capacity),
        local_secondary_indexes: map |> Map.get("LocalSecondaryIndexes") |> StructMap.to_struct(Capacity),
        read_capacity_units: map |> Map.get("ReadCapacityUnits"),
        table: map |> Map.get("Table") |> Table.to_struct,
        table_name: map |> Map.get("TableName"),
        write_capacity_units: map |> Map.get("WriteCapacityUnits"),
      }
    end
  end
  defmodule Capacity do
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
      %Capacity{
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
        "Keys" => struct.keys |> Enum.map(&(&1 |> StructMap.to_map(Key))),
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
        keys: value |> Map.get("Keys") |> Enum.map(&(&1 |> StructMap.to_struct(Key))),
        projection_expression: value |> Map.get("ProjectionExpression"),
        consistent_read: value |> Map.get("ConsistentRead")
      }
    end
  end
  defmodule ExpressionAttributeName do
    defstruct [
      :name,
      :value
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{struct.name => struct.value}
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      %ExpressionAttributeName{
        name: map |> Map.keys |> List.first,
        value: map |> Map.values |> List.first
      }
    end
  end
  defmodule ItemCollectionMetrics do
    defstruct [
      :item_collection_key,
      :size_estimate_range_gb
    ]
    def to_map(nil), do: nil
    def to_map(struct) do
      %{
        "ItemCollectionKey" => struct.item_collection_key |> StructMap.to_map(Key),
        "SizeEstimateRangeGB" => struct.size_estimate_range_gb
      }
    end
    def to_struct(nil), do: nil
    def to_struct(map) do
      %ItemCollectionMetrics{
        item_collection_key: map |> Map.get("ItemCollectionKey") |> StructMap.to_struct(Key),
        size_estimate_range_gb: map |> Map.get("SizeEstimateRangeGB")
      }
    end
  end
end
