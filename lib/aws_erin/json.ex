defmodule AwsErin.Json do
  @moduledoc """
  Documentation for Json.
  """

  @doc """
  Encode to JSON from map.
  """
  @spec encode(map()) :: String.t
  def encode(map) do
    map |> Jason.encode!
  end

  @doc """
  Decode to map from JSON.
  """
  @spec decode(String.t) :: map()
  def decode(json) do
    json |> Jason.decode!
  end
end
