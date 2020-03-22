defmodule AwsErin.DynamoDB.Error do
  defstruct [ :message ]
  defmodule UnknownServerError, do: defstruct [ :message ]
  defmodule InternalServerError, do: defstruct [ :message ]
  defmodule ProvisionedThroughputExceededException, do: defstruct [ :message ]
  defmodule RequestLimitExceeded, do: defstruct [ :message ]
  defmodule ResourceNotFoundException, do: defstruct [ :message ]

  defmodule ConditionalCheckFailedException, do: defstruct [ :message ]

  def to_error(500, code, message) do
    cond do
      code |> String.ends_with?("InternalServerError") -> %InternalServerError{message: message}
      true -> %UnknownServerError{message: message}
    end
  end

  def to_error(400, code, message) do
    cond do
      code |> String.ends_with?("ProvisionedThroughputExceededException") -> %ProvisionedThroughputExceededException{message: message}
      code |> String.ends_with?("RequestLimitExceeded") -> %RequestLimitExceeded{message: message}
      code |> String.ends_with?("ResourceNotFoundException") -> %ResourceNotFoundException{message: message}
      code |> String.ends_with?("ConditionalCheckFailedException") -> %ConditionalCheckFailedException{message: message}
      true -> %UnknownServerError{message: message}
    end
  end

end
