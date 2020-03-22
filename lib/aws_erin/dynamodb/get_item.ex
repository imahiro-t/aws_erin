defmodule AwsErin.DynamoDB.GetItem do
  defmodule Request do
    defstruct [
      :key,
      :table_name,
      :expression_attribute_names,
      :projection_expression,
      :return_consumed_capacity,
      consistent_read: false
    ]
  end

  defmodule Response do
    defstruct [
      :consumed_capacity,
      :item
    ]
  end
end
