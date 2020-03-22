defmodule AwsErin.DynamoDB.DeleteItem do
  defmodule Request do
    defstruct [
      :key,
      :table_name,
      :condition_expression,
      :expression_attribute_names,
      :expression_attribute_values,
      :return_consumed_capacity,
      :return_item_collection_metrics,
      :return_values
    ]
  end

  defmodule Response do
    defstruct [
      :attributes,
      :consumed_capacity,
      :item_collection_metrics
    ]
  end
end
