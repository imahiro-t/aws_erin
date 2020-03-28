defmodule AwsErin.S3.ResponseBehaviour do

  @callback to_struct(headers :: list(), body :: binary) :: struct()

end