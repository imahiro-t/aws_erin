defmodule AwsErin.S3 do
  alias AwsErin.Util
  alias AwsErin.Http
  @s3 "s3"

  @moduledoc """
  Documentation for S3.
  """

  @doc """
  Get S3 object.

  """
  def get_object(bucket_name, key_name, options \\ []) do
    headers = Map.new()
    query_params = Map.new()
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(bucket_name, key_name, region_name, query_params)
    case Http.get(endpoint_uri, region_name, @s3, headers, options) do
      {:ok, %{body: body}} ->
        key_r = ~r/\A<\?xml version="1.0" encoding="UTF-8"\?>\n<Error><Code>NoSuchKey<\/Code>.*<\/Error>\z/
        bucket_r = ~r/\A<\?xml version="1.0" encoding="UTF-8"\?>\n<Error><Code>NoSuchBucket<\/Code>.*<\/Error>\z/
        cond do
          key_r |> Regex.match?(body) -> {:error, :key_not_found}
          bucket_r |> Regex.match?(body) -> {:error, :bucket_not_found}
          true -> {:ok, body}
        end
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

  @doc """
  Put S3 object.

  """
  def put_object(bucket_name, key_name, body, options \\ []) do
    headers =
      Map.new()
      |> Map.put("content-length", "#{body |> byte_size}")

    query_params = Map.new()
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(bucket_name, key_name, region_name, query_params)
    case Http.put(endpoint_uri, region_name, @s3, headers, body, options) do
      {:ok, %{body: body}} ->
        bucket_r = ~r/\A<\?xml version="1.0" encoding="UTF-8"\?>\n<Error><Code>NoSuchBucket<\/Code>.*<\/Error>\z/
        cond do
          bucket_r |> Regex.match?(body) -> {:error, :bucket_not_found}
          true -> {:ok, body}
        end
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

  @doc """
  Delete S3 object.

  """
  def delete_object(bucket_name, key_name, options \\ []) do
    headers = Map.new()
    query_params = Map.new()
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(bucket_name, key_name, region_name, query_params)
    case Http.delete(endpoint_uri, region_name, @s3, headers, options) do
      {:ok, %{body: body}} ->
        bucket_r = ~r/\A<\?xml version="1.0" encoding="UTF-8"\?>\n<Error><Code>NoSuchBucket<\/Code>.*<\/Error>\z/
        cond do
          bucket_r |> Regex.match?(body) -> {:error, :bucket_not_found}
          true -> {:ok, body}
        end
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

  defp get_endpoint_uri(bucket_name, key_name, "us-east-1", query_params) do
    %URI{
      host: "s3.amazonaws.com",
      path: "/#{bucket_name}/#{key_name}",
      port: 443,
      query: query_params |> URI.encode_query,
      scheme: "https"
    }
  end

  defp get_endpoint_uri(bucket_name, key_name, region_name, query_params) do
    %URI{
      host: "s3.#{region_name}.amazonaws.com",
      path: "/#{bucket_name}/#{key_name}",
      port: 443,
      query: query_params |> URI.encode_query,
      scheme: "https"
    }
  end
end
