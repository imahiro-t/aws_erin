defmodule AwsErin.Auth do
  alias AwsErin.Util

  @moduledoc """
  Documentation for AWS authentication.
  """

  @terminator "aws4_request"
  @algorithm "AWS4-HMAC-SHA256"

  @doc """
  Get authorization for AWS.

  """
  def get_authorization(
        aws_access_key,
        aws_secret_key,
        endpoint_uri,
        http_request_method,
        region_name,
        service_name,
        date_time,
        headers,
        request_payload
      ) do
    region_name = region_name || "us-east-1"

    canonical_request =
      get_canonical_request(endpoint_uri, http_request_method, headers, request_payload)

    string_to_sign = get_string_to_sign(region_name, service_name, date_time, canonical_request)
    signing_key = derive_signing_key(aws_secret_key, region_name, service_name, date_time)
    signature = calcurate_signature(signing_key, string_to_sign)

    credentials_authorization_header =
      "Credential=#{aws_access_key}/#{get_credential_scope(region_name, service_name, date_time)}"

    signed_headers_authorization_header = "SignedHeaders=#{get_signed_headers(headers)}"
    signature_authorization_header = "Signature=#{signature}"

    "#{@algorithm} #{credentials_authorization_header}, #{signed_headers_authorization_header}, #{
      signature_authorization_header
    }"
  end

  defp get_canonical_request(
         %URI{path: path, query: query},
         http_request_method,
         headers,
         request_payload
       ) do
    http_request_method <>
      "\n" <>
      get_canonical_uri(path) <>
      "\n" <>
      get_canonical_query_string(URI.decode_query(query || "")) <>
      "\n" <>
      get_canonical_headers(headers) <>
      "\n" <>
      get_signed_headers(headers) <>
      "\n" <>
      get_hashed_payload(request_payload)
  end

  defp get_canonical_uri(path) when is_nil(path) or path == "", do: "/"
  defp get_canonical_uri(path), do: path

  defp get_canonical_query_string(query_params = %{}) do
    query_params
    |> Map.keys()
    |> Enum.reduce(Map.new(), fn x, acc ->
      acc |> Map.put(x |> URI.encode(), query_params |> Map.get(x) || "" |> URI.encode())
    end)
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.map(&"#{elem(&1, 0)}=#{elem(&1, 1)}")
    |> Enum.join("&")
  end

  defp get_canonical_headers(headers = %{}) do
    headers
    |> Enum.sort_by(&(elem(&1, 0) |> String.downcase()))
    |> Enum.map(&get_canonical_header/1)
    |> Enum.join()
  end

  defp get_canonical_header({key, value}) do
    "#{key |> String.downcase()}:#{value |> String.trim() |> String.replace(~r/\s+/, " ")}\n"
  end

  defp get_signed_headers(headers = %{}) do
    headers
    |> Map.keys()
    |> Enum.map(&String.downcase/1)
    |> Enum.sort()
    |> Enum.join(";")
  end

  defp get_hashed_payload(request_payload) do
    request_payload |> Util.hash() |> Util.hex_encode()
  end

  defp get_string_to_sign(region_name, service_name, date_time, canonical_request) do
    credential_scope = get_credential_scope(region_name, service_name, date_time)
    hashed_canonical_request = get_hashed_canonical_request(canonical_request)
    "#{@algorithm}\n#{date_time}\n#{credential_scope}\n#{hashed_canonical_request}"
  end

  defp get_credential_scope(region_name, service_name, date_time) do
    "#{date_time |> get_date()}/#{region_name}/#{service_name}/#{@terminator}"
  end

  defp get_date(date_time), do: date_time |> String.slice(0..7)

  defp get_hashed_canonical_request(canonical_request) do
    canonical_request |> Util.hash() |> Util.hex_encode()
  end

  defp derive_signing_key(aws_secret_key, region_name, service_name, date_time) do
    Util.hmac("AWS4#{aws_secret_key}", date_time |> get_date())
    |> Util.hmac(region_name)
    |> Util.hmac(service_name)
    |> Util.hmac(@terminator)
  end

  defp calcurate_signature(signing_key, string_to_sign) do
    signing_key |> Util.hmac(string_to_sign) |> Util.hex_encode()
  end
end
