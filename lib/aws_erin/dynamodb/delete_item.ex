defmodule AwsErin.DynamoDB.DeleteItem do
  alias AwsErin.DynamoDB.Behaviour
  alias AwsErin.DynamoDB.Common.StructMap
  alias AwsErin.DynamoDB.Common.Key
  alias AwsErin.DynamoDB.Common.ExpressionAttributeName
  alias AwsErin.DynamoDB.Common.Attribute
  alias AwsErin.DynamoDB.Common.ConsumedCapacity
  alias AwsErin.DynamoDB.Common.ItemCollectionMetrics

  defmodule Request do
    @behaviour Behaviour.Request
    defstruct [
      :key,
      :table_name,
      :condition_expression,
      :expression_attribute_names,
      :expression_attribute_values,
      :return_consumed_capacity,
      :return_item_collection_metrics,
      :return_values
    ]
    def to_map(struct) do
      %{
        "Key" => struct.key |> StructMap.to_map(Key),
        "TableName" => struct.table_name,
        "ConditionExpression" => struct.condition_expression,
        "ExpressionAttributeNames" => struct.expression_attribute_names |> ExpressionAttributeName.to_map,
        "ExpressionAttributeValues" => struct.expression_attribute_values |> StructMap.to_map(Attribute),
        "ReturnConsumedCapacity" => struct.return_consumed_capacity,
        "ReturnItemCollectionMetrics" => struct.return_item_collection_metrics,
        "ReturnValues" => struct.return_values
      }
    end
    def to_struct(map) do
      %Request{
        key: map |> Map.get("Key") |> StructMap.to_struct(Key),
        table_name: map |> Map.get("TableName"),
        condition_expression: map |> Map.get("ConditionExpression"),
        expression_attribute_names: map |> Map.get("ExpressionAttributeNames") |> ExpressionAttributeName.to_struct,
        expression_attribute_values: map |> Map.get("s") |> StructMap.to_struct(Attribute),
        return_consumed_capacity: map |> Map.get("ReturnConsumedCapacity"),
        return_item_collection_metrics: map |> Map.get("ReturnItemCollectionMetrics"),
        return_values: map |> Map.get("ReturnValues")
      }
    end
  end

  defmodule Response do
    @behaviour Behaviour.Response
    defstruct [
      :attributes,
      :consumed_capacity,
      :item_collection_metrics
    ]
    def to_map(struct) do
      %{
        "Attributes" => struct.attributes |> StructMap.to_map(Attribute),
        "ConsumedCapacity" => struct.consumed_capacity |> ConsumedCapacity.to_map,
        "ItemCollectionMetrics" => struct.item_collection_metrics |> ItemCollectionMetrics.to_map
      }
    end
    def to_struct(map) do
      %Response{
        attributes: map |> Map.get("Attributes") |> StructMap.to_struct(Attribute),
        consumed_capacity: map |> Map.get("ConsumedCapacity") |> ConsumedCapacity.to_struct,
        item_collection_metrics: map |> Map.get("ItemCollectionMetrics") |> ItemCollectionMetrics.to_struct
      }
    end
  end
end
