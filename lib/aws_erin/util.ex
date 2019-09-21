defmodule AwsErin.Util do
  @moduledoc """
  Documentation for Util.
  """

  @doc """
  Generate SHA256 hash value.

  ## Examples

      iex> AwsErin.Util.hash("erin")
      <<124, 188, 203, 12, 76, 170, 223, 159, 205, 181, 30, 228, 87, 168, 40, 204,
        114, 164, 88, 121, 131, 27, 91, 151, 138, 226, 226, 206, 252, 68, 151, 5>>

  """
  def hash(str \\ "") do
    :crypto.hash(:sha256, str)
  end

  @doc """
  Encode to Base 16 value with lower case.

  ## Examples

      iex> AwsErin.Util.hex_encode("erin")
      "6572696e"

  """
  def hex_encode(str \\ "") do
    str
    |> Base.encode16(case: :lower)
  end

  @doc """
  Generate HMAC-SHA256 hash value.

  ## Examples

      iex> AwsErin.Util.hmac("secret", "erin")
      <<66, 116, 70, 47, 123, 250, 150, 31, 51, 11, 16, 118, 149, 254, 106, 254, 89,
        65, 153, 52, 185, 191, 44, 50, 250, 254, 55, 172, 101, 31, 249, 250>>

  """
  def hmac(secret, str) do
    :crypto.hmac(:sha256, secret, str)
  end

  @doc """
  Get configuration value for :aws_erin's application.

  ## Examples

      iex> AwsErin.Util.fetch_env!(:aws_default_region)
      "ap-northeast-1"
      
  """
  def fetch_env!(key) do
    Application.fetch_env!(:aws_erin, key)
  end
end
