defmodule AwsErin.SQS do
  alias AwsErin.Util
  alias AwsErin.Http
  @sqs "sqs"

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
    case Http.get(endpoint_uri, region_name, @sqs, headers, options) do
      {:ok, %{body: body}} ->
        r = ~r/\A<\?xml version="1.0"\?><ErrorResponse xmlns="http:\/\/queue.amazonaws.com\/doc\/2012-11-05\/"><Error><Type>Sender<\/Type><Code>AWS.SimpleQueueService.NonExistentQueue<\/Code>.*<\/ErrorResponse>\z/
        cond do
          r |> Regex.match?(body) -> {:error, :queue_not_found}
          true -> {:ok, body}
        end
      {:error, %{reason: reason}} -> {:error, reason}
    end
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
