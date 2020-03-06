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

  def get_dynamodb_item(value) do
    request = %AwsErin.DynamoDB.GetItem.Request{
      TableName: "MyTable", 
      Key: %{LockKey: %{S: value}},
      ProjectionExpression: "LockKey",
      ConsistentRead: true,
      ReturnConsumedCapacity: "TOTAL"
    }
    AwsErin.DynamoDB.get_item(request, region_name: "ap-northeast-1")
  end

  def put_dynamodb_item(value) do
    ttl = (DateTime.utc_now |> DateTime.to_unix) + 120
    request = %AwsErin.DynamoDB.PutItem.Request{
      TableName: "MyTable", 
      Item: %{LockKey: %{S: value}, ttl: %{N: "#{ttl}"}},
      ConditionExpression: "attribute_not_exists(LockKey)",
    }
    AwsErin.DynamoDB.put_item(request, region_name: "ap-northeast-1")
  end

  def delete_dynamodb_item(value) do
    request = %AwsErin.DynamoDB.DeleteItem.Request{
      TableName: "MyTable", 
      Key: %{LockKey: %{S: value}},
    }
    AwsErin.DynamoDB.delete_item(request, region_name: "ap-northeast-1")
  end
end
