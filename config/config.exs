use Mix.Config

config :aws_erin,
  aws_access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  aws_secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  aws_default_region: System.get_env("AWS_DEFAULT_REGION")
