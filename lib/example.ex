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
      table_name: "MyTable", 
      key: [
        %AwsErin.DynamoDB.Common.Key{name: "id", value: value}
      ],
      projection_expression: "id",
      consistent_read: true,
      return_consumed_capacity: "TOTAL"
    }
    AwsErin.DynamoDB.get_item(request, region_name: "ap-northeast-1")
  end

  def put_dynamodb_item(value) do
    ttl = (DateTime.utc_now |> DateTime.to_unix) + 120
    request = %AwsErin.DynamoDB.PutItem.Request{
      table_name: "MyTable",
      item: [
        %AwsErin.DynamoDB.Common.Key{name: "id", value: value},
        %AwsErin.DynamoDB.Common.Key{name: "ttl", value: ttl}
      ],
      condition_expression: "attribute_not_exists(id)",
    }
    AwsErin.DynamoDB.put_item(request, region_name: "ap-northeast-1")
  end

  def delete_dynamodb_item(value) do
    request = %AwsErin.DynamoDB.DeleteItem.Request{
      table_name: "MyTable", 
      key: [
        %AwsErin.DynamoDB.Common.Key{name: "id", value: value}
      ]
    }
    AwsErin.DynamoDB.delete_item(request, region_name: "ap-northeast-1")
  end
end
