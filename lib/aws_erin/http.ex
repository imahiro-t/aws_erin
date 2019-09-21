defmodule AwsErin.Http do
  alias AwsErin.Util
  alias AwsErin.Auth

  @moduledoc """
  Documentation for AWS HTTP.
  """

  @doc """
  POST AWS rest api.

  """
  def post(endpoint_uri, region_name, service_name, headers, request_payload) do
    request(endpoint_uri, "POST", region_name, service_name, headers, request_payload)
  end

  @doc """
  PUT AWS rest api.

  """
  def put(endpoint_uri, region_name, service_name, headers, request_payload) do
    request(endpoint_uri, "PUT", region_name, service_name, headers, request_payload)
  end

  @doc """
  GET AWS rest api.

  """
  def get(endpoint_uri, region_name, service_name, headers) do
    request(endpoint_uri, "GET", region_name, service_name, headers)
  end

  @doc """
  DELETE AWS rest api.

  """
  def delete(endpoint_uri, region_name, service_name, headers) do
    request(endpoint_uri, "DELETE", region_name, service_name, headers)
  end

  @doc """
  Request AWS rest api.

  """
  def request(
        endpoint_uri = %URI{host: host},
        http_request_method,
        region_name,
        service_name,
        headers,
        request_payload \\ ""
      ) do
    aws_access_key = Util.fetch_env!(:aws_access_key_id)
    aws_secret_key = Util.fetch_env!(:aws_secret_access_key)
    date_time = get_date_time()

    headers =
      headers
      |> Map.put("x-amz-date", date_time)
      |> Map.put("Host", host)

    headers =
      if(request_payload,
        do: headers |> Map.put("x-amz-content-sha256", get_hashed_payload(request_payload)),
        else: headers
      )

    authorization =
      Auth.get_authorization(
        aws_access_key,
        aws_secret_key,
        endpoint_uri,
        http_request_method,
        region_name,
        service_name,
        date_time,
        headers,
        request_payload
      )

    headers =
      headers
      |> Map.put("Authorization", authorization)

    case HTTPoison.request(http_request_method, endpoint_uri, request_payload, headers) do
      {:ok, %{body: body}} -> body
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

  defp get_hashed_payload(request_payload) do
    request_payload |> Util.hash() |> Util.hex_encode()
  end

  defp get_date_time do
    DateTime.utc_now() |> DateTime.to_iso8601(:basic) |> String.replace(~r/\.\d+/, "")
  end
end
