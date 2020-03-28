defmodule AwsErin.S3.PutObject do
  alias AwsErin.S3.Behaviour

  defmodule Request do
    @behaviour Behaviour.Request
    defstruct [
      :body,
      :bucket,
      :key,
      :x_amz_acl,
      :cache_control,
      :content_disposition,
      :content_encoding,
      :content_language,
      :content_length,
      :content_md5,
      :content_type,
      :expires,
      :x_amz_grant_full_control,
      :x_amz_grant_read,
      :x_amz_grant_read_acp,
      :x_amz_grant_write_acp,
      :x_amz_server_side_encryption,
      :x_amz_storage_class,
      :x_amz_website_redirect_location,
      :x_amz_server_side_encryption_customer_algorithm,
      :x_amz_server_side_encryption_customer_key,
      :x_amz_server_side_encryption_customer_key_md5,
      :x_amz_server_side_encryption_aws_kms_key_id,
      :x_amz_server_side_encryption_context,
      :x_amz_request_payer,
      :x_amz_tagging,
      :x_amz_object_lock_mode,
      :x_amz_object_lock_retain_until_date,
      :x_amz_object_lock_legal_hold
    ]
    def header_map(%Request{} = struct) do
      Map.new
      |> Behaviour.Request.put_map(struct, "x-amz-acl", :x_amz_acl)
      |> Behaviour.Request.put_map(struct, "Cache-Control", :cache_control)
      |> Behaviour.Request.put_map(struct, "Content-Disposition", :content_disposition)
      |> Behaviour.Request.put_map(struct, "Content-Encoding", :content_encoding)
      |> Behaviour.Request.put_map(struct, "Content-Language", :content_language)
      |> Behaviour.Request.put_map(struct, "Content-Length", :content_length)
      |> Behaviour.Request.put_map(struct, "Content-MD5", :content_md5)
      |> Behaviour.Request.put_map(struct, "Content-Type", :content_type)
      |> Behaviour.Request.put_map(struct, "Expires", :expires)
      |> Behaviour.Request.put_map(struct, "x-amz-grant-full-control", :x_amz_grant_full_control)
      |> Behaviour.Request.put_map(struct, "x-amz-grant-read", :x_amz_grant_read)
      |> Behaviour.Request.put_map(struct, "x-amz-grant-read-acp", :x_amz_grant_read_acp)
      |> Behaviour.Request.put_map(struct, "x-amz-grant-write-acp", :x_amz_grant_write_acp)
      |> Behaviour.Request.put_map(struct, "x-amz-server-side-encryption", :x_amz_server_side_encryption)
      |> Behaviour.Request.put_map(struct, "x-amz-storage-class", :x_amz_storage_class)
      |> Behaviour.Request.put_map(struct, "x-amz-website-redirect-location", :x_amz_website_redirect_location)
      |> Behaviour.Request.put_map(struct, "x-amz-server-side-encryption-customer-algorithm", :x_amz_server_side_encryption_customer_algorithm)
      |> Behaviour.Request.put_map(struct, "x-amz-server-side-encryption-customer-key", :x_amz_server_side_encryption_customer_key)
      |> Behaviour.Request.put_map(struct, "x-amz-server-side-encryption-customer-key-MD5", :x_amz_server_side_encryption_customer_key_md5)
      |> Behaviour.Request.put_map(struct, "x-amz-server-side-encryption-aws-kms-key-id", :x_amz_server_side_encryption_aws_kms_key_id)
      |> Behaviour.Request.put_map(struct, "x-amz-server-side-encryption-context", :x_amz_server_side_encryption_context)
      |> Behaviour.Request.put_map(struct, "x-amz-request-payer", :x_amz_request_payer)
      |> Behaviour.Request.put_map(struct, "x-amz-tagging", :x_amz_tagging)
      |> Behaviour.Request.put_map(struct, "x-amz-object-lock-mode", :x_amz_object_lock_mode)
      |> Behaviour.Request.put_map(struct, "x-amz-object-lock-retain-until-date", :x_amz_object_lock_retain_until_date)
      |> Behaviour.Request.put_map(struct, "x-amz-object-lock-legal-hold", :x_amz_object_lock_legal_hold)
    end
    def query_map(%Request{} = _struct) do
      Map.new
    end
  end

  defmodule Response do
    @behaviour Behaviour.Response
    defstruct [
      :x_amz_expiration,
      :e_tag,
      :x_amz_server_side_encryption,
      :x_amz_version_id,
      :x_amz_server_side_encryption_customer_algorithm,
      :x_amz_server_side_encryption_customer_key_md5,
      :x_amz_server_side_encryption_aws_kms_key_id,
      :x_amz_server_side_encryption_context,
      :x_amz_request_charged
    ]
    def to_struct(headers, _body) do
      headers |> Enum.reduce(%Response{}, fn {key, value}, acc -> 
        key = key |> struct_key
        if(key |> is_nil, do: acc, else: %{acc | key => value})
      end)
    end
    defp struct_key(key) do
      case key do
        "x-amz-expiration" -> :x_amz_expiration
        "ETag" -> :e_tag
        "x-amz-server-side-encryption" -> :x_amz_server_side_encryption
        "x-amz-version-id" -> :x_amz_version_id
        "x-amz-server-side-encryption-customer-algorithm" -> :x_amz_server_side_encryption_customer_algorithm
        "x-amz-server-side-encryption-customer-key-MD5" -> :x_amz_server_side_encryption_customer_key_md5
        "x-amz-server-side-encryption-aws-kms-key-id" -> :x_amz_server_side_encryption_aws_kms_key_id
        "x-amz-server-side-encryption-context" -> :x_amz_server_side_encryption_context
        "x-amz-request-charged" -> :x_amz_request_charged
        _ -> nil
      end
    end
  end
end
