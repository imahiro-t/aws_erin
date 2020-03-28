defmodule AwsErin.DynamoDB.BatchWriteItem do
  alias AwsErin.DynamoDB.Behaviour
  alias AwsErin.DynamoDB.Common.StructList
  alias AwsErin.DynamoDB.Common.StructMap
  alias AwsErin.DynamoDB.Common.RequestWriteItems
  alias AwsErin.DynamoDB.Common.ConsumedCapacity
  alias AwsErin.DynamoDB.Common.ItemCollectionMetrics
  alias AwsErin.DynamoDB.Common.UnprocessedItems

  defmodule Request do
    @behaviour Behaviour.Request
    defstruct [
      :request_items,
      :return_consumed_capacity,
      :return_item_collection_metrics
    ]
    def to_map(struct) do
      %{
        "RequestItems" => struct.request_items |> StructMap.to_map(RequestWriteItems),
        "ReturnConsumedCapacity" => struct.return_consumed_capacity,
        "ReturnItemCollectionMetrics" => struct.return_item_collection_metrics
      }
    end
    def to_struct(map) do
      %Request{
        request_items: map |> Map.get("RequestItems") |> StructMap.to_struct(RequestWriteItems),
        return_consumed_capacity: map |> Map.get("ReturnConsumedCapacity"),
        return_item_collection_metrics: map |> Map.get("ReturnItemCollectionMetrics")
      }
    end
  end

  defmodule Response do
    @behaviour Behaviour.Response
    defstruct [
      :consumed_capacity,
      :item_collection_metrics,
      :unprocessed_items
    ]
    def to_map(struct) do
      %{
        "ConsumedCapacity" => struct.consumed_capacity |> StructList.to_map(ConsumedCapacity),
        "ItemCollectionMetrics" => struct.item_collection_metrics |> ItemCollectionMetrics.to_map,
        "UnprocessedItems" => struct.unprocessed_items |> StructMap.to_map(UnprocessedItems)
      }
    end
    def to_struct(map) do
      %Response{
        consumed_capacity: map |> Map.get("ConsumedCapacity") |> StructList.to_struct(ConsumedCapacity),
        item_collection_metrics: map |> Map.get("ItemCollectionMetrics") |> ItemCollectionMetrics.to_struct,
        unprocessed_items: map |> Map.get("UnprocessedItems") |> StructMap.to_struct(UnprocessedItems)
      }
    end
  end
end
