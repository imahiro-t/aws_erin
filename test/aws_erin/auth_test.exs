defmodule AwsErin.AuthTest do
  use ExUnit.Case
  doctest AwsErin.Auth

  test "get_authorization" do
    date_time = "20150830T123600Z"
    host = "example.amazonaws.com"

    headers =
      Map.new()
      |> Map.put("x-amz-date", date_time)
      |> Map.put("Host", host)

    assert AwsErin.Auth.get_authorization(
             "AKIDEXAMPLE",
             "wJalrXUtnFEMI/K7MDENG+bPxRfiCYEXAMPLEKEY",
             %URI{
               host: host,
               path: "/",
               query: "Param2=value2&Param1=value1"
             },
             "GET",
             "us-east-1",
             "service",
             date_time,
             headers,
             ""
           ) ==
             "AWS4-HMAC-SHA256 Credential=AKIDEXAMPLE/20150830/us-east-1/service/aws4_request, SignedHeaders=host;x-amz-date, Signature=b97d918cfa904a5beff61c982a1b6f458b799221646efd99d3219ec94cdf2500"
  end
end
