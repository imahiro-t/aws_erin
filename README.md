# AwsErin

AWS SDK for elixir. Authentication and http access is done. It is under construction.

## Installation

The package can be installed by adding `aws_erin` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:aws_erin, "~> 0.3.4"}
  ]
end
```
## Basic Usage

```elixir
options = [
  aws_access_key_id: "AWS_ACCESS_KEY_ID",
  aws_secret_access_key: "AWS_SECRET_ACCESS_KEY",
  aws_session_token: "AWS_SESSION_TOKEN", # if any
  aws_region: "AWS_REGION"
]
AwsErin.S3.get_object("bucket_name", "key_name", options)
```

The docs can be found at [https://hexdocs.pm/aws_erin](https://hexdocs.pm/aws_erin).
