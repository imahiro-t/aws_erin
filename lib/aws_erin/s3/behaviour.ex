defmodule AwsErin.S3.Behaviour do

  defmodule Request do
    @callback header_map(struct :: struct()) :: map()
    @callback query_map(struct :: struct()) :: map()
    def put_map(map, struct, map_key, struct_key) do
      value = struct |> Map.get(struct_key)
      if (value |> is_nil) do
        map
      else
        map |> Map.put(map_key, value)
      end
    end
  end

  defmodule Response do
    @callback to_struct(headers :: list(), body :: binary) :: struct()  
  end

end