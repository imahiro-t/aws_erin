defmodule AwsErin.Http do
  alias AwsErin.Util
  alias AwsErin.Auth

  @moduledoc """
  Documentation for AWS HTTP.
  """

  @doc """
  POST AWS rest api.

  """
  @spec post(%URI{}, String.t, String.t, map(), String.t, list()) :: {:ok, %HTTPoison.Response{}} | {:error, %HTTPoison.Error{}}
  def post(endpoint_uri, region_name, service_name, headers = %{}, request_payload, options) do
    request(endpoint_uri, "POST", region_name, service_name, headers, request_payload, options)
  end

  @doc """
  PUT AWS rest api.

  """
  @spec put(%URI{}, String.t, String.t, map(), String.t, list()) :: {:ok, %HTTPoison.Response{}} | {:error, %HTTPoison.Error{}}
  def put(endpoint_uri, region_name, service_name, headers = %{}, request_payload, options) do
    request(endpoint_uri, "PUT", region_name, service_name, headers, request_payload, options)
  end

  @doc """
  GET AWS rest api.

  """
  @spec get(%URI{}, String.t, String.t, map(), list()) :: {:ok, %HTTPoison.Response{}} | {:error, %HTTPoison.Error{}}
  def get(endpoint_uri, region_name, service_name, headers = %{}, options) do
    request(endpoint_uri, "GET", region_name, service_name, headers, "", options)
  end

  @doc """
  DELETE AWS rest api.

  """
  @spec delete(%URI{}, String.t, String.t, map(), list()) :: {:ok, %HTTPoison.Response{}} | {:error, %HTTPoison.Error{}}
  def delete(endpoint_uri, region_name, service_name, headers = %{}, options) do
    request(endpoint_uri, "DELETE", region_name, service_name, headers, "", options)
  end

  @doc """
  Request AWS rest api.

  """
  @spec request(%URI{}, String.t, String.t, String.t, map(), String.t, list()) :: {:ok, %HTTPoison.Response{}} | {:error, %HTTPoison.Error{}}
  def request(
        %URI{host: host} = endpoint_uri,
        http_request_method,
        region_name,
        service_name,
        headers = %{},
        request_payload,
        options \\ []
      ) do
    aws_access_key = options |> get_aws_access_key
    aws_secret_key = options |> get_aws_secret_key
    aws_session_token = options |> get_aws_session_token
    date_time = get_date_time()

    headers =
      headers
      |> Map.put("x-amz-date", date_time)
      |> Map.put("Host", host)
      |> put_session_token(aws_session_token)
      |> put_request_payload(request_payload)

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

    HTTPoison.request(http_request_method, endpoint_uri, request_payload, headers)
  end

  defp get_aws_access_key(options) do
    case options |> Keyword.get(:aws_access_key_id) do
      nil -> System.get_env("AWS_ACCESS_KEY_ID")
      value -> value
    end
  end

  defp get_aws_secret_key(options) do
    case options |> Keyword.get(:aws_secret_access_key) do
      nil -> System.get_env("AWS_SECRET_ACCESS_KEY")
      value -> value
    end
  end

  defp get_aws_session_token(options) do
    case options |> Keyword.get(:aws_session_token) do
      nil -> System.get_env("AWS_SESSION_TOKEN")
      value -> value
    end
  end

  defp get_date_time do
    DateTime.utc_now() |> DateTime.to_iso8601(:basic) |> String.replace(~r/\.\d+/, "")
  end

  defp put_session_token(headers, aws_session_token) when is_nil(aws_session_token), do: headers
  defp put_session_token(headers, aws_session_token) do
    headers
    |> Map.put("x-amz-security-token", aws_session_token)
  end

  defp put_request_payload(headers, request_payload) when is_nil(request_payload), do: headers
  defp put_request_payload(headers, request_payload) do
    headers
    |> Map.put("x-amz-content-sha256", request_payload |> get_hashed_payload)
  end

  defp get_hashed_payload(request_payload) do
    request_payload |> Util.hash() |> Util.hex_encode()
  end
end
