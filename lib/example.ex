defmodule Example do
  def get_s3_object(bucket_name, file_name) do
    AwsErin.S3.get_object(bucket_name, file_name, region_name: "ap-northeast-1")
  end

  def put_s3_object(bucket_name, file_name, body) do
    AwsErin.S3.put_object(bucket_name, file_name, body, region_name: "ap-northeast-1")
  end

  def delete_s3_object(bucket_name, file_name) do
    AwsErin.S3.delete_object(bucket_name, file_name, region_name: "ap-northeast-1")
  end

  def list_dynamodb_tables() do
    AwsErin.DynamoDB.list_tables(region_name: "ap-northeast-1")
  end
end
