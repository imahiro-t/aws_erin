defmodule AwsErin.DynamoDB.Error do

  @type t :: %__MODULE__{
    message: String.t
  }
  defstruct [ :message ]

  defmodule UnknownServerError, do: defstruct [ :message ]
  defmodule InternalServerError, do: defstruct [ :message ]
  defmodule ProvisionedThroughputExceededException, do: defstruct [ :message ]
  defmodule RequestLimitExceeded, do: defstruct [ :message ]
  defmodule ResourceNotFoundException, do: defstruct [ :message ]
  defmodule ValidationException, do: defstruct [ :message ]
  defmodule ConditionalCheckFailedException, do: defstruct [ :message ]
  defmodule ItemCollectionSizeLimitExceededException, do: defstruct [ :message ]
  defmodule TransactionConflictException, do: defstruct [ :message ]

  def to_error(500, code, message) do
    cond do
      code |> String.ends_with?("InternalServerError") -> %InternalServerError{message: message}
      true -> %UnknownServerError{message: "#{code} #{message}"}
    end
  end

  def to_error(400, code, message) do
    cond do
      code |> String.ends_with?("ProvisionedThroughputExceededException") -> %ProvisionedThroughputExceededException{message: message}
      code |> String.ends_with?("RequestLimitExceeded") -> %RequestLimitExceeded{message: message}
      code |> String.ends_with?("ResourceNotFoundException") -> %ResourceNotFoundException{message: message}
      code |> String.ends_with?("ValidationException") -> %ValidationException{message: message}
      code |> String.ends_with?("ConditionalCheckFailedException") -> %ConditionalCheckFailedException{message: message}
      code |> String.ends_with?("ItemCollectionSizeLimitExceededException") -> %ItemCollectionSizeLimitExceededException{message: message}
      code |> String.ends_with?("TransactionConflictException") -> %TransactionConflictException{message: message}
      true -> %UnknownServerError{message: "#{code} #{message}"}
    end
  end

end
