defmodule AwsErin.SQS do
  alias AwsErin.Util
  alias AwsErin.Http

  @moduledoc """
  Documentation for SQS.
  """

  @doc """
  Send Message.

  """
  def send_message(queue_url, message, options \\ []) do
    headers = Map.new()
    query_params = Map.new
      |> Map.put("Action", "SendMessage")
      |> Map.put("MessageBody", message)
      |> Map.put("Version", "2012-11-05")
    region_name = options |> Util.get_region_name
    endpoint_uri = get_endpoint_uri(queue_url, query_params)
    Http.get(endpoint_uri, region_name, "sqs", headers, options)
  end

  defp get_endpoint_uri(queue_url, query_params) do
    uri = queue_url |> URI.parse
    %URI{
      host: uri.host,
      path: uri.path,
      port: uri.port,
      query: query_params |> URI.encode_query,
      scheme: uri.scheme
    }
  end
end
