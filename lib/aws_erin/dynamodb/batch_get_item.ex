defmodule AwsErin.DynamoDB.BatchGetItem do
  alias AwsErin.DynamoDB.Behaviour
  alias AwsErin.DynamoDB.Common.StructList
  alias AwsErin.DynamoDB.Common.StructMap
  alias AwsErin.DynamoDB.Common.RequestItem
  alias AwsErin.DynamoDB.Common.ConsumedCapacity
  alias AwsErin.DynamoDB.Common.Response, as: CmnResponse
  alias AwsErin.DynamoDB.Common.UnprocessedKey

  defmodule Request do
    @behaviour Behaviour.Request
    defstruct [
      :request_items,
      :return_consumed_capacity
    ]
    def to_map(struct) do
      %{
        "RequestItems" => struct.request_items |> StructMap.to_map(RequestItem),
        "ReturnConsumedCapacity" => struct.return_consumed_capacity
      }
    end
    def to_struct(map) do
      %Request{
        request_items: map |> Map.get("RequestItems") |> StructMap.to_struct(RequestItem),
        return_consumed_capacity: map |> Map.get("ReturnConsumedCapacity")
      }
    end
  end

  defmodule Response do
    @behaviour Behaviour.Response
    defstruct [
      :consumed_capacity,
      :responses,
      :unprocessed_keys
    ]
    def to_map(struct) do
      %{
        "ConsumedCapacity" => struct.consumed_capacity |> StructList.to_map(ConsumedCapacity),
        "Responses" => struct.responses |> StructMap.to_map(CmnResponse),
        "UnprocessedKeys" => struct.unprocessed_keys |> StructMap.to_map(UnprocessedKey)
      }
    end
    def to_struct(map) do
      %Response{
        consumed_capacity: map |> Map.get("ConsumedCapacity") |> StructList.to_struct(ConsumedCapacity),
        responses: map |> Map.get("Responses") |> StructMap.to_struct(CmnResponse),
        unprocessed_keys: map |> Map.get("UnprocessedKeys") |> StructMap.to_struct(UnprocessedKey)
      }
    end
  end
end
