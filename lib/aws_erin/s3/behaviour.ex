defmodule AwsErin.S3.Behaviour do

  defmodule Request do
    @callback header_map(map :: map(), struct :: struct()) :: map()
    @callback query_map(map :: map(), struct :: struct()) :: map()
  end

  defmodule Response do
    @callback to_struct(headers :: list(), body :: binary) :: struct()  
  end

end