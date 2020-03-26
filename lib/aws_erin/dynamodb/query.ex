defmodule AwsErin.DynamoDB.Query do
  alias AwsErin.DynamoDB.Common.StructMap
  alias AwsErin.DynamoDB.Common.Key
  alias AwsErin.DynamoDB.Common.ExpressionAttributeName
  alias AwsErin.DynamoDB.Common.Attribute
  alias AwsErin.DynamoDB.Common.ConsumedCapacity
  alias AwsErin.DynamoDB.Common.Item

  defmodule Request do
    defstruct [
      :exclusive_start_key,
      :table_name,
      :expression_attribute_names,
      :expression_attribute_values,
      :filter_expression,
      :index_name,
      :key_condition_expression,
      :limit,
      :projection_expression,
      :return_consumed_capacity,
      :scan_index_forward,
      :select,
      consistent_read: false
    ]
    def to_map(struct) do
      %{
        "ExclusiveStartKey" => struct.exclusive_start_key |> StructMap.to_map(Key),
        "TableName" => struct.table_name,
        "ExpressionAttributeNames" => struct.expression_attribute_names |> ExpressionAttributeName.to_map,
        "ExpressionAttributeValues" => struct.expression_attribute_values |> StructMap.to_map(Attribute),
        "FilterExpression" => struct.filter_expression,
        "IndexName" => struct.index_name,
        "KeyConditionExpression" => struct.key_condition_expression,
        "Limit" => struct.limit,
        "ProjectionExpression" => struct.projection_expression,
        "ReturnConsumedCapacity" => struct.return_consumed_capacity,
        "ScanIndexForward" => struct.scan_index_forward,
        "Select" => struct.select,
        "ConsistentRead" => struct.consistent_read
      }
    end
    def to_struct(map) do
      %Request{
        exclusive_start_key: map |> Map.get("ExclusiveStartKey") |> StructMap.to_struct(Key),
        table_name: map |> Map.get("TableName"),
        expression_attribute_names: map |> Map.get("ExpressionAttributeNames") |> ExpressionAttributeName.to_struct,
        expression_attribute_values: map |> Map.get("ExpressionAttributeValues") |> StructMap.to_struct(Attribute),
        filter_expression: map |> Map.get("FilterExpression"),
        index_name: map |> Map.get("IndexName"),
        key_condition_expression: map |> Map.get("KeyConditionExpression"),
        limit: map |> Map.get("Limit"),
        projection_expression: map |> Map.get("ProjectionExpression"),
        return_consumed_capacity: map |> Map.get("ReturnConsumedCapacity"),
        scan_index_forward: map |> Map.get("ScanIndexForward"),
        select: map |> Map.get("Select"),
        consistent_read: map |> Map.get("ConsistentRead")
      }
    end
  end

  defmodule Response do
    defstruct [
      :consumed_capacity,
      :count,
      :items,
      :last_evaluated_key,
      :scanned_count
    ]
    def to_map(struct) do
      %{
        "ConsumedCapacity" => struct.consumed_capacity |> ConsumedCapacity.to_map,
        "Count" => struct.count,
        "Items" => struct.items |> Enum.map(&(&1 |> StructMap.to_map(Item))),
        "LastEvaluatedKey" => struct.last_evaluated_key |> StructMap.to_map(Key),
        "ScannedCount" => struct.scanned_count
      }
    end
    def to_struct(map) do
      %Response{
        consumed_capacity: map |> Map.get("ConsumedCapacity") |> ConsumedCapacity.to_struct,
        count: map |> Map.get("Count"),
        items: map |> Map.get("Items") |> Enum.map(&(&1 |> StructMap.to_struct(Item))),
        last_evaluated_key: map |> Map.get("LastEvaluatedKey") |> StructMap.to_struct(Key),
        scanned_count: map |> Map.get("ScannedCount")
      }
    end
  end
end
