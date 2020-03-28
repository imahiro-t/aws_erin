defmodule AwsErin.Json do
  @moduledoc """
  Documentation for Json.
  """

  @doc """
  Encode to JSON from map.
  """
  def encode(map) do
    map |> Jason.encode!
  end

  @doc """
  Decode to map from JSON.
  """
  def decode(json) do
    json |> Jason.decode!
  end
end
