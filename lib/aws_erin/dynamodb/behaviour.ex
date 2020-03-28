defmodule AwsErin.DynamoDB.Behaviour do

  defmodule Request do
    @callback to_map(struct :: struct()) :: map()
    @callback to_struct(map :: map()) :: struct()
  end

  defmodule Response do
    @callback to_map(struct :: struct()) :: map()
    @callback to_struct(map :: map()) :: struct()
  end

end