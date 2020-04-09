defmodule AwsErin.DynamoDB do
  alias AwsErin.Util
  alias AwsErin.Json
  alias AwsErin.Http
  alias AwsErin.DynamoDB.Error
  alias AwsErin.DynamoDB.Error.UnknownServerError
  alias AwsErin.DynamoDB.GetItem
  alias AwsErin.DynamoDB.PutItem
  alias AwsErin.DynamoDB.UpdateItem
  alias AwsErin.DynamoDB.DeleteItem
  alias AwsErin.DynamoDB.BatchGetItem
  alias AwsErin.DynamoDB.BatchWriteItem
  alias AwsErin.DynamoDB.Query
  alias AwsErin.DynamoDB.Scan
  @dynamodb "dynamodb"
  @common_headers %{"Content-Type" => "application/x-amz-json-1.0"}

  @moduledoc """
  Documentation for DynamoDB.
  """

  @doc """
  GetItem.
  """
  @spec get_item(%GetItem.Request{}, keyword()) :: {:ok, %GetItem.Response{}} | {:error, %AwsErin.DynamoDB.Error{}}
  def get_item(%GetItem.Request{} = request, options \\ []) do
    process_request(request, options, "GetItem", GetItem.Request, GetItem.Response)
  end

  @doc """
  PutItem.
  """
  @spec put_item(%PutItem.Request{}, keyword()) :: {:ok, %PutItem.Response{}} | {:error, %AwsErin.DynamoDB.Error{}}
  def put_item(%PutItem.Request{} = request, options \\ []) do
    process_request(request, options, "PutItem", PutItem.Request, PutItem.Response)
  end

  @doc """
  UpdateItem.
  """
  @spec update_item(%UpdateItem.Request{}, keyword()) :: {:ok, %UpdateItem.Response{}} | {:error, %AwsErin.DynamoDB.Error{}}
  def update_item(%UpdateItem.Request{} = request, options \\ []) do
    process_request(request, options, "UpdateItem", UpdateItem.Request, UpdateItem.Response)
  end

  @doc """
  DeleteItem.
  """
  @spec delete_item(%DeleteItem.Request{}, keyword()) :: {:ok, %DeleteItem.Response{}} | {:error, %AwsErin.DynamoDB.Error{}}
  def delete_item(%DeleteItem.Request{} = request, options \\ []) do
    process_request(request, options, "DeleteItem", DeleteItem.Request, DeleteItem.Response)
  end

  @doc """
  BatchGetItem.
  """
  @spec batch_get_item(%BatchGetItem.Request{}, keyword()) :: {:ok, %BatchGetItem.Response{}} | {:error, %AwsErin.DynamoDB.Error{}}
  def batch_get_item(%BatchGetItem.Request{} = request, options \\ []) do
    process_request(request, options, "BatchGetItem", BatchGetItem.Request, BatchGetItem.Response)
  end

  @doc """
  BatchWriteItem.
  """
  @spec batch_write_item(%BatchWriteItem.Request{}, keyword()) :: {:ok, %BatchWriteItem.Response{}} | {:error, %AwsErin.DynamoDB.Error{}}
  def batch_write_item(%BatchWriteItem.Request{} = request, options \\ []) do
    process_request(request, options, "BatchWriteItem", BatchWriteItem.Request, BatchWriteItem.Response)
  end

  @doc """
  Query.
  """
  @spec query(%Query.Request{}, keyword()) :: {:ok, %Query.Response{}} | {:error, %AwsErin.DynamoDB.Error{}}
  def query(%Query.Request{} = request, options \\ []) do
    process_request(request, options, "Query", Query.Request, Query.Response)
  end

  @doc """
  QueryAll.
  """
  @spec query_all(%Query.Request{}, keyword()) :: {:ok, %Query.Response{}} | {:error, %AwsErin.DynamoDB.Error{}}
  def query_all(%Query.Request{} = request, options \\ []) do
    query_all_internal(request, %Query.Response{count: 0, items: [], scanned_count: 0}, options)
  end

  defp query_all_internal(%Query.Request{} = request, %Query.Response{} = acc, options) do
    case query(request, options) do
      {:ok, %Query.Response{last_evaluated_key: nil} = response} ->
        merge_query_response(acc, response)
      {:ok, response} ->
        query_all_internal(%{request | exclusive_start_key: response.last_evaluated_key}, merge_query_response(acc, response), options)
      other ->
        other
    end
  end

  defp merge_query_response(%Query.Response{} = acc, %Query.Response{} = response) do
    %{response | 
      count: acc.count + response.count,
      items: acc.items ++ response.items,
      scanned_count: acc.scanned_count + response.scanned_count
    }
  end

  @doc """
  Scan.
  """
  @spec scan(%Scan.Request{}, keyword()) :: {:ok, %Scan.Response{}} | {:error, %AwsErin.DynamoDB.Error{}}
  def scan(%Scan.Request{} = request, options \\ []) do
    process_request(request, options, "Scan", Scan.Request, Scan.Response)
  end


  @doc """
  ScanAll.
  """
  @spec scan_all(%Scan.Request{}, keyword()) :: {:ok, %Scan.Response{}} | {:error, %AwsErin.DynamoDB.Error{}}
  def scan_all(%Scan.Request{} = request, options \\ []) do
    scan_all_internal(request, %Scan.Response{count: 0, items: [], scanned_count: 0}, options)
  end

  defp scan_all_internal(%Scan.Request{} = request, %Scan.Response{} = acc, options) do
    case scan(request, options) do
      {:ok, %Scan.Response{last_evaluated_key: nil} = response} ->
        merge_scan_response(acc, response)
      {:ok, response} ->
        scan_all_internal(%{request | exclusive_start_key: response.last_evaluated_key}, merge_scan_response(acc, response), options)
      other ->
        other
    end
  end

  defp merge_scan_response(%Scan.Response{} = acc, %Scan.Response{} = response) do
    %{response | 
      count: acc.count + response.count,
      items: acc.items ++ response.items,
      scanned_count: acc.scanned_count + response.scanned_count
    }
  end

  defp process_request(request, options, name, request_struct, response_struct) do
    headers = @common_headers
    |> Map.put("X-Amz-Target", "DynamoDB_20120810.#{name}")
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(region_name, options)
    Http.post(endpoint_uri, region_name, @dynamodb, headers, request |> request_struct.to_map |> Json.encode, options)
    |> to_response(response_struct)
  end

  defp get_endpoint_uri(region_name, options) do
    case options |> get_dynamodb_endpoint do
      nil ->
        %URI{
          host: "dynamodb.#{region_name}.amazonaws.com",
          port: 443,
          scheme: "https"
        }
      value ->
        value |> URI.parse
    end
  end

  defp get_dynamodb_endpoint(options) do
    case options |> Keyword.get(:dynamodb_endpoint) do
      nil -> System.get_env("DYNAMODB_ENDPOINT")
      value -> value
    end
  end

  defp to_response(response, struct) do
    case response do
      {:ok, %{body: body, status_code: status_code}} when status_code == 400 or status_code == 500 ->
        case body |> Json.decode do
          %{"__type" => code, "message" => message} -> {:error, Error.to_error(status_code, code, message)}
          %{"__type" => code, "Message" => message} -> {:error, Error.to_error(status_code, code, message)}
        end
      {:ok, %{body: body, status_code: 200}} ->
        case body |> Json.decode do
          map -> {:ok, map |> struct.to_struct}
        end
      {:error, %{reason: reason}} -> {:error, %UnknownServerError{message: reason}}
    end
  end
end
