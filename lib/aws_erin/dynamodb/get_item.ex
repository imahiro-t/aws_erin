defmodule AwsErin.DynamoDB.GetItem do
  alias AwsErin.DynamoDB.Behaviour
  alias AwsErin.DynamoDB.Common.StructMap
  alias AwsErin.DynamoDB.Common.Key
  alias AwsErin.DynamoDB.Common.ExpressionAttributeName
  alias AwsErin.DynamoDB.Common.ConsumedCapacity
  alias AwsErin.DynamoDB.Common.Item

  defmodule Request do
    @behaviour Behaviour.Request
    defstruct [
      :key,
      :table_name,
      :expression_attribute_names,
      :projection_expression,
      :return_consumed_capacity,
      consistent_read: false
    ]
    def to_map(struct) do
      %{
        "Key" => struct.key |> StructMap.to_map(Key),
        "TableName" => struct.table_name,
        "ExpressionAttributeNames" => struct.expression_attribute_names |> ExpressionAttributeName.to_map,
        "ProjectionExpression" => struct.projection_expression,
        "ReturnConsumedCapacity" => struct.return_consumed_capacity,
        "ConsistentRead" => struct.consistent_read
      }
    end
    def to_struct(map) do
      %Request{
        key: map |> Map.get("Key") |> StructMap.to_struct(Key),
        table_name: map |> Map.get("TableName"),
        expression_attribute_names: map |> Map.get("ExpressionAttributeNames") |> ExpressionAttributeName.to_struct,
        projection_expression: map |> Map.get("ProjectionExpression"),
        return_consumed_capacity: map |> Map.get("ReturnConsumedCapacity"),
        consistent_read: map |> Map.get("ConsistentRead")
      }
    end
  end

  defmodule Response do
    @behaviour Behaviour.Response
    defstruct [
      :consumed_capacity,
      :item
    ]
    def to_map(struct) do
      %{
        "ConsumedCapacity" => struct.consumed_capacity |> ConsumedCapacity.to_map,
        "Item" => struct.item |> StructMap.to_map(Item)
      }
    end
    def to_struct(map) do
      %Response{
        consumed_capacity: map |> Map.get("ConsumedCapacity") |> ConsumedCapacity.to_struct,
        item: map |> Map.get("Item") |> StructMap.to_struct(Item)
      }
    end
  end
end
