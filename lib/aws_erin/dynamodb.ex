defmodule AwsErin.DynamoDB do
  alias AwsErin.Util
  alias AwsErin.Http

  @moduledoc """
  Documentation for DynamoDB.
  """

  @doc """
  List DynamoDB tables.

  """
  def list_tables(options \\ []) do
    region_name = Keyword.get(options, :region_name, Util.fetch_env!(:aws_default_region))

    endpoint_uri = %URI{
      host: "dynamodb.#{region_name}.amazonaws.com",
      port: 443,
      scheme: "https"
    }

    body = "{}"

    headers =
      Map.new()
      |> Map.put("Content-Type", "application/x-amz-json-1.0")
      |> Map.put("X-Amz-Target", "DynamoDB_20120810.ListTables")

    Http.post(
      endpoint_uri,
      region_name,
      "dynamodb",
      headers,
      body
    )
  end
end
