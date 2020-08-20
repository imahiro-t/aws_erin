# AwsErin

AWS SDK for elixir. Authentication and http access is done. It is under construction.

## Installation

The package can be installed by adding `aws_erin` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:aws_erin, "~> 0.4.2"}
  ]
end
```
## Basic Usage

```elixir
options = [
  aws_access_key_id: "AWS_ACCESS_KEY_ID", # use system env "AWS_ACCESS_KEY_ID" if nil
  aws_secret_access_key: "AWS_SECRET_ACCESS_KEY", # use system env "AWS_SECRET_ACCESS_KEY" if nil
  aws_session_token: "AWS_SESSION_TOKEN", # optional, use system env "AWS_SESSION_TOKEN" if nil
  aws_region: "AWS_REGION" # use system env "AWS_REGION" if nil
]
request = %AwsErin.DynamoDB.PutItem.Request{
  condition_expression: "ForumName <> :f and Subject <> :s",
  expression_attribute_names: nil,
  expression_attribute_values: [ 
    %AwsErin.DynamoDB.Common.Attribute{name: ":f", value: "Amazon DynamoDB"},
    %AwsErin.DynamoDB.Common.Attribute{
      name: ":s",
      value: "How do I update multiple items?"
    }
  ],
  item: [
    %AwsErin.DynamoDB.Common.Item{name: "ForumName", value: "Amazon DynamoDB"},
    %AwsErin.DynamoDB.Common.Item{
      name: "LastPostDateTime",
      value: "201303190422"
    },
    %AwsErin.DynamoDB.Common.Item{
      name: "LastPostedBy",
      value: "fred@example.com"
    },
    %AwsErin.DynamoDB.Common.Item{
      name: "Message",
      value: "I want to update multiple items in a single call. What's the best way to do that?"
    },
    %AwsErin.DynamoDB.Common.Item{
      name: "Subject",
      value: "How do I update multiple items?"
    },
    %AwsErin.DynamoDB.Common.Item{
      name: "Tags",
      value: ["Update", "Multiple Items", "HelpMe"]
    }
  ],
  return_consumed_capacity: nil,
  return_item_collection_metrics: nil,
  return_values: nil,
  table_name: "Thread"
}
AwsErin.DynamoDB.put_item(request, options)
```

The docs can be found at [https://hexdocs.pm/aws_erin](https://hexdocs.pm/aws_erin).
