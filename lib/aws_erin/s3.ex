defmodule AwsErin.S3 do
  alias AwsErin.Util
  alias AwsErin.Http
  alias AwsErin.S3.Error
  alias AwsErin.S3.Error.UnknownServerError
  alias AwsErin.S3.GetObject
  alias AwsErin.S3.PutObject
  alias AwsErin.S3.DeleteObject
  alias AwsErin.S3.DeleteObjects
  @s3 "s3"

  @moduledoc """
  Documentation for S3.
  """

  @doc """
  GetObject.
  """
  @spec get_object(%GetObject.Request{}, list()) :: {:ok, %GetObject.Response{}} | {:error, %Error{}}
  def get_object(%GetObject.Request{} = request, options \\ []) do
    headers = GetObject.Request.header_map(request)
    query_params = GetObject.Request.query_map(request)
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(request.bucket, request.key, region_name, query_params)
    Http.get(endpoint_uri, region_name, @s3, headers, options) |> to_response(GetObject.Response)
  end

  @doc """
  PutObject.
  """
  @spec put_object(%PutObject.Request{}, list()) :: {:ok, %PutObject.Response{}} | {:error, %Error{}}
  def put_object(%PutObject.Request{} = request, options \\ []) do
    headers = PutObject.Request.header_map(request)
    query_params = PutObject.Request.query_map(request)
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(request.bucket, request.key, region_name, query_params)
    Http.put(endpoint_uri, region_name, @s3, headers, request.body, options) |> to_response(PutObject.Response)
  end

  @doc """
  DeleteObject.
  """
  @spec delete_object(%DeleteObject.Request{}, list()) :: {:ok, %DeleteObject.Response{}} | {:error, %Error{}}
  def delete_object(%DeleteObject.Request{} = request, options \\ []) do
    headers = DeleteObject.Request.header_map(request)
    query_params = DeleteObject.Request.query_map(request)
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(request.bucket, request.key, region_name, query_params)
    Http.delete(endpoint_uri, region_name, @s3, headers, options) |> to_response(DeleteObject.Response)
  end

  @doc """
  DeleteObjects.
  """
  @spec delete_objects(%DeleteObjects.Request{}, list()) :: {:ok, %DeleteObjects.Response{}} | {:error, %Error{}}
  def delete_objects(%DeleteObjects.Request{} = request, options \\ []) do
    body = DeleteObjects.Request.body(request)
    headers = DeleteObjects.Request.header_map(request)
    |> Map.put("Content-MD5", :crypto.hash(:md5, body) |> Base.encode64)
    query_params = DeleteObjects.Request.query_map(request)
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(request.bucket, "", region_name, query_params)
    Http.post(endpoint_uri, region_name, @s3, headers, body, options) |> to_response(DeleteObjects.Response)
  end

  defp get_endpoint_uri(bucket_name, key_name, region_name, query_params) do
    %URI{
      host: "#{bucket_name}.s3.#{region_name}.amazonaws.com",
      path: "/#{key_name}",
      port: 443,
      query: query_params |> URI.encode_query,
      scheme: "https"
    }
  end

  defp to_response(response, struct) do
    case response do
      {:ok, %{headers: headers, body: body, status_code: status_code}} when status_code == 200 or status_code == 204 ->
        {:ok, struct.to_struct(headers, body)}
      {:ok, %{body: body, status_code: status_code}} ->
        {:error, Error.to_error(status_code, body)}
      {:error, %{reason: reason}} -> {:error, %UnknownServerError{message: reason}}
    end
  end

end
