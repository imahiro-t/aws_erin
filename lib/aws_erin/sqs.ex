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
    Http.get(endpoint_uri, region_name, @sqs, headers, options) |> response
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

  defp response(res) do
    case res do
      {:ok, %{body: body}} ->
        reg = ~r/\A<\?xml version="1.0"\?><ErrorResponse xmlns="http:\/\/queue.amazonaws.com\/doc\/2012-11-05\/"><Error><Type>Sender<\/Type><Code>(?<code>.*?)<\/Code>.*<Message>(?<message>.*?)<\/Message>.*/
        case reg |> Regex.named_captures(body) do
          %{"code" => code, "message" => message} -> {:error, {code, message}}
          _ -> {:ok, body}
        end
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

end
