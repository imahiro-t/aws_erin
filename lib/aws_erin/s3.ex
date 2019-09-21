defmodule AwsErin.S3 do
  alias AwsErin.Util
  alias AwsErin.Http

  @moduledoc """
  Documentation for S3.
  """

  @doc """
  Get S3 object.

  """
  def get_object(bucket_name, key_name, options \\ []) do
    headers = Map.new()
    query_params = Map.new()
    region_name = get_region_name(options)
    endpoint_uri = get_endpoint_uri(bucket_name, key_name, region_name, query_params)
    Http.get(endpoint_uri, region_name, "s3", headers)
  end

  @doc """
  Put S3 object.

  """
  def put_object(bucket_name, key_name, body, options \\ []) do
    headers =
      Map.new()
      |> Map.put("content-length", "#{body |> String.length()}")

    query_params = Map.new()
    region_name = get_region_name(options)
    endpoint_uri = get_endpoint_uri(bucket_name, key_name, region_name, query_params)
    Http.put(endpoint_uri, region_name, "s3", headers, body)
  end

  @doc """
  Delete S3 object.

  """
  def delete_object(bucket_name, key_name, options \\ []) do
    headers = Map.new()
    query_params = Map.new()
    region_name = get_region_name(options)
    endpoint_uri = get_endpoint_uri(bucket_name, key_name, region_name, query_params)
    Http.delete(endpoint_uri, region_name, "s3", headers)
  end

  defp get_region_name(options) do
    Keyword.get(options, :region_name, Util.fetch_env!(:aws_default_region))
  end

  defp get_endpoint_uri(bucket_name, key_name, "us-east-1", query_params) do
    %URI{
      host: "s3.amazonaws.com",
      path: "/#{bucket_name}/#{key_name}",
      port: 443,
      query: URI.encode_query(query_params),
      scheme: "https"
    }
  end

  defp get_endpoint_uri(bucket_name, key_name, region_name, query_params) do
    %URI{
      host: "s3.#{region_name}.amazonaws.com",
      path: "/#{bucket_name}/#{key_name}",
      port: 443,
      query: URI.encode_query(query_params),
      scheme: "https"
    }
  end
end
