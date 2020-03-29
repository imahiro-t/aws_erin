defmodule AwsErin.Xml do
  @moduledoc """
  Documentation for Xml.
  """

  @doc """
  Decode to map from XML.
  """
  @spec decode(String.t) :: map()
  def decode(json) do
    json |> XmlToMap.naive_map
  end
end
