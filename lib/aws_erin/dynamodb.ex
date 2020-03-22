defmodule AwsErin.DynamoDB do
  alias AwsErin.Util
  alias AwsErin.Http
  alias AwsErin.DynamoDB.Error
  alias AwsErin.DynamoDB.Error.UnknownServerError
  alias AwsErin.DynamoDB.GetItem
  alias AwsErin.DynamoDB.BatchGetItem
  alias AwsErin.DynamoDB.PutItem
  alias AwsErin.DynamoDB.DeleteItem
  @dynamodb "dynamodb"
  @common_headers %{"Content-Type" => "application/x-amz-json-1.0"}

  @moduledoc """
  Documentation for DynamoDB.
  """

  @doc """
  Batch Get item.

  """
  @spec batch_get_item(%BatchGetItem.Request{}, list()) :: {:ok, %BatchGetItem.Response{}} | {:error, %AwsErin.DynamoDB.Error{}}
  def batch_get_item(request = %{__struct__: BatchGetItem.Request}, options \\ []) do
    headers =
      @common_headers
      |> Map.put("X-Amz-Target", "DynamoDB_20120810.BatchGetItem")
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(region_name)
    Http.post(endpoint_uri, region_name, @dynamodb, headers, request |> BatchGetItem.Request.to_map |> Jason.encode!, options)
    |> to_response(BatchGetItem.Response)
  end

  @doc """
  Get item.

  """
  @spec get_item(%GetItem.Request{}, list()) :: {:ok, %GetItem.Response{}} | {:error, %AwsErin.DynamoDB.Error{}}
  def get_item(request = %{__struct__: GetItem.Request}, options \\ []) do
    headers =
      @common_headers
      |> Map.put("X-Amz-Target", "DynamoDB_20120810.GetItem")
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(region_name)
    Http.post(endpoint_uri, region_name, @dynamodb, headers, request |> GetItem.Request.to_map |> Jason.encode!, options)
    |> to_response(GetItem.Response)
  end

  @doc """
  Put item.

  """
  @spec put_item(%PutItem.Request{}, list()) :: {:ok, %PutItem.Response{}} | {:error, %AwsErin.DynamoDB.Error{}}
  def put_item(request = %{__struct__: PutItem.Request}, options \\ []) do
    headers =
      @common_headers
      |> Map.put("X-Amz-Target", "DynamoDB_20120810.PutItem")
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(region_name)
    Http.post(endpoint_uri, region_name, @dynamodb, headers, request |> PutItem.Request.to_map |> Jason.encode!, options)
    |> to_response(PutItem.Response)
  end

  @doc """
  Delete item.

  """
  @spec delete_item(%DeleteItem.Request{}, list()) :: {:ok, %DeleteItem.Response{}} | {:error, %AwsErin.DynamoDB.Error{}}
  def delete_item(request = %{__struct__: DeleteItem.Request}, options \\ []) do
    headers =
      @common_headers
      |> Map.put("X-Amz-Target", "DynamoDB_20120810.DeleteItem")
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(region_name)
    Http.post(endpoint_uri, region_name, @dynamodb, headers, request |> DeleteItem.Request.to_map |> Jason.encode!, options)
    |> to_response(DeleteItem.Response)
  end

  defp get_endpoint_uri(region_name) do
    %URI{
      host: "dynamodb.#{region_name}.amazonaws.com",
      port: 443,
      scheme: "https"
    }
  end

  defp to_response(response, struct) do
    case response do
      {:ok, %{body: body, status_code: status_code}} when status_code == 400 or status_code == 500 ->
        case body |> Jason.decode! do
          %{"__type" => code, "message" => message} -> {:error, Error.to_error(status_code, code, message)}
          %{"__type" => code, "Message" => message} -> {:error, Error.to_error(status_code, code, message)}
        end
      {:ok, %{body: body, status_code: 200}} ->
        case body |> Jason.decode! do
          map -> {:ok, map |> struct.to_struct}
        end
      {:error, %{reason: reason}} -> {:error, %UnknownServerError{message: reason}}
    end
  end
end
