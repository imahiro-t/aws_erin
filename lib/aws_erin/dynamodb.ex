defmodule AwsErin.DynamoDB do
  alias AwsErin.Util
  alias AwsErin.Http
  alias AwsErin.DynamoDB.GetItem
  alias AwsErin.DynamoDB.PutItem
  alias AwsErin.DynamoDB.DeleteItem
  @dynamodb "dynamodb"

  @moduledoc """
  Documentation for DynamoDB.
  """

  @doc """
  Get item.

  """
  @spec get_item(%GetItem.Request{}, list()) :: {:ok, %GetItem.Response{}} | {:error, {String.t, String.t}} | {:error, String.t}
  def get_item(request = %{__struct__: GetItem.Request}, options \\ []) do
    headers =
      Map.new()
      |> Map.put("Content-Type", "application/x-amz-json-1.0")
      |> Map.put("X-Amz-Target", "DynamoDB_20120810.GetItem")
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(region_name)
    Http.post(endpoint_uri, region_name, @dynamodb, headers, request |> Map.from_struct |> Jason.encode!, options)
    |> response(GetItem.Response)
  end

  @doc """
  Put item.

  """
  @spec put_item(%PutItem.Request{}, list()) :: {:ok, %PutItem.Response{}} | {:error, {String.t, String.t}} | {:error, String.t}
  def put_item(request = %{__struct__: PutItem.Request}, options \\ []) do
    headers =
      Map.new()
      |> Map.put("Content-Type", "application/x-amz-json-1.0")
      |> Map.put("X-Amz-Target", "DynamoDB_20120810.PutItem")
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(region_name)
    Http.post(endpoint_uri, region_name, @dynamodb, headers, request |> Map.from_struct |> Jason.encode!, options)
    |> response(PutItem.Response)
  end

  @doc """
  Delete item.

  """
  @spec delete_item(%DeleteItem.Request{}, list()) :: {:ok, %DeleteItem.Response{}} | {:error, {String.t, String.t}} | {:error, String.t}
  def delete_item(request = %{__struct__: DeleteItem.Request}, options \\ []) do
    headers =
      Map.new()
      |> Map.put("Content-Type", "application/x-amz-json-1.0")
      |> Map.put("X-Amz-Target", "DynamoDB_20120810.DeleteItem")
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(region_name)
    Http.post(endpoint_uri, region_name, @dynamodb, headers, request |> Map.from_struct |> Jason.encode!, options)
    |> response(DeleteItem.Response)
  end

  defp get_endpoint_uri(region_name) do
    %URI{
      host: "dynamodb.#{region_name}.amazonaws.com",
      port: 443,
      scheme: "https"
    }
  end

  defp response(res, struct) do
    case res do
      {:ok, %{body: body}} ->
        case body |> Jason.decode! do
          %{"__type" => code, "message" => message} -> {:error, {code, message}}
          %{"__type" => code, "Message" => message} -> {:error, {code, message}}
          map -> {:ok, struct(struct, map |> atom_map)}
        end
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

  defp atom_map(map) do
    map
    |> Enum.reduce(%{}, fn {x, y}, acc -> acc |> Map.put(x |> to_string |> String.to_atom, y) end)
  end

  defmodule GetItem do
    defmodule Request do
      defstruct [
        :Key,
        :TableName,
        :ExpressionAttributeNames,
        :ProjectionExpression,
        :ReturnConsumedCapacity,
        ConsistentRead: false
      ]
    end

    defmodule Response do
      defstruct [
        :ConsumedCapacity,
        :Item
      ]
    end
  end

  defmodule PutItem do
    defmodule Request do
      defstruct [
        :Item,
        :TableName,
        :ConditionExpression,
        :ExpressionAttributeNames,
        :ExpressionAttributeValues,
        :ReturnConsumedCapacity,
        :ReturnItemCollectionMetrics,
        :ReturnValues
      ]
    end

    defmodule Response do
      defstruct [
        :Attributes,
        :ConsumedCapacity,
        :ItemCollectionMetrics
      ]
    end
  end

  defmodule DeleteItem do
    defmodule Request do
      defstruct [
        :Key,
        :TableName,
        :ConditionExpression,
        :ExpressionAttributeNames,
        :ExpressionAttributeValues,
        :ReturnConsumedCapacity,
        :ReturnItemCollectionMetrics,
        :ReturnValues
      ]
    end

    defmodule Response do
      defstruct [
        :Attributes,
        :ConsumedCapacity,
        :ItemCollectionMetrics
      ]
    end
  end
end
