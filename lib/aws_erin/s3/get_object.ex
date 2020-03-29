defmodule AwsErin.S3.GetObject do
  alias AwsErin.S3.Behaviour

  defmodule Request do
    @behaviour Behaviour.Request
    @type t :: %__MODULE__{
      bucket: String.t,
      key: String.t,
      part_number: String.t,
      response_cache_control: String.t,
      response_content_disposition: String.t,
      response_content_encoding: String.t,
      response_content_language: String.t,
      response_content_type: String.t,
      response_expires: String.t,
      version_id: String.t,
      if_match: String.t,
      if_modified_since: String.t,
      if_none_match: String.t,
      if_unmodified_since: String.t,
      range: String.t,
      x_amz_server_side_encryption_customer_algorithm: String.t,
      x_amz_server_side_encryption_customer_key: String.t,
      x_amz_server_side_encryption_customer_key_md5: String.t,
      x_amz_request_payer: String.t  
    }
    defstruct [
      :bucket,
      :key,
      :part_number,
      :response_cache_control,
      :response_content_disposition,
      :response_content_encoding,
      :response_content_language,
      :response_content_type,
      :response_expires,
      :version_id,
      :if_match,
      :if_modified_since,
      :if_none_match,
      :if_unmodified_since,
      :range,
      :x_amz_server_side_encryption_customer_algorithm,
      :x_amz_server_side_encryption_customer_key,
      :x_amz_server_side_encryption_customer_key_md5,
      :x_amz_request_payer
    ]
    def header_map(%Request{} = struct) do
      Map.new
      |> Behaviour.Request.put_map(struct, "If-Match", :if_match)
      |> Behaviour.Request.put_map(struct, "If-Modified-Since", :if_modified_since)
      |> Behaviour.Request.put_map(struct, "If-None-Match", :if_none_match)
      |> Behaviour.Request.put_map(struct, "If-Unmodified-Since", :if_unmodified_since)
      |> Behaviour.Request.put_map(struct, "Range", :range)
      |> Behaviour.Request.put_map(struct, "x-amz-server-side-encryption-customer-algorithm", :x_amz_server_side_encryption_customer_algorithm)
      |> Behaviour.Request.put_map(struct, "x-amz-server-side-encryption-customer-key", :x_amz_server_side_encryption_customer_key)
      |> Behaviour.Request.put_map(struct, "x-amz-server-side-encryption-customer-key-MD5", :x_amz_server_side_encryption_customer_key_md5)
      |> Behaviour.Request.put_map(struct, "x-amz-request-payer", :x_amz_request_payer)
    end
    def query_map(%Request{} = struct) do
      Map.new
      |> Behaviour.Request.put_map(struct, "PartNumber", :part_number)
      |> Behaviour.Request.put_map(struct, "ResponseCacheControl", :response_cache_control)
      |> Behaviour.Request.put_map(struct, "ResponseContentDisposition", :response_content_disposition)
      |> Behaviour.Request.put_map(struct, "ResponseContentEncoding", :response_content_encoding)
      |> Behaviour.Request.put_map(struct, "ResponseContentLanguage", :response_content_language)
      |> Behaviour.Request.put_map(struct, "ResponseContentType", :response_content_type)
      |> Behaviour.Request.put_map(struct, "ResponseExpires", :response_expires)
      |> Behaviour.Request.put_map(struct, "VersionId", :version_id)
    end
  end

  defmodule Response do
    @behaviour Behaviour.Response
    @type t :: %__MODULE__{
      body: String.t,
      x_amz_delete_marker: String.t,
      accept_ranges: String.t,
      x_amz_expiration: String.t,
      x_amz_restore: String.t,
      last_modified: String.t,
      content_length: String.t,
      e_tag: String.t,
      x_amz_missing_meta: String.t,
      x_amz_version_id: String.t,
      cache_control: String.t,
      content_disposition: String.t,
      content_encoding: String.t,
      content_language: String.t,
      content_range: String.t,
      content_type: String.t,
      expires: String.t,
      x_amz_website_redirect_location: String.t,
      x_amz_server_side_encryption: String.t,
      x_amz_server_side_encryption_customer_algorithm: String.t,
      x_amz_server_side_encryption_customer_key_md5: String.t,
      x_amz_server_side_encryption_aws_kms_key_id: String.t,
      x_amz_storage_class: String.t,
      x_amz_request_charged: String.t,
      x_amz_replication_status: String.t,
      x_amz_mp_parts_count: String.t,
      x_amz_tagging_count: String.t,
      x_amz_object_lock_mode: String.t,
      x_amz_object_lock_retain_until_date: String.t,
      x_amz_object_lock_legal_hold: String.t
    }
    defstruct [
      :body,
      :x_amz_delete_marker,
      :accept_ranges,
      :x_amz_expiration,
      :x_amz_restore,
      :last_modified,
      :content_length,
      :e_tag,
      :x_amz_missing_meta,
      :x_amz_version_id,
      :cache_control,
      :content_disposition,
      :content_encoding,
      :content_language,
      :content_range,
      :content_type,
      :expires,
      :x_amz_website_redirect_location,
      :x_amz_server_side_encryption,
      :x_amz_server_side_encryption_customer_algorithm,
      :x_amz_server_side_encryption_customer_key_md5,
      :x_amz_server_side_encryption_aws_kms_key_id,
      :x_amz_storage_class,
      :x_amz_request_charged,
      :x_amz_replication_status,
      :x_amz_mp_parts_count,
      :x_amz_tagging_count,
      :x_amz_object_lock_mode,
      :x_amz_object_lock_retain_until_date,
      :x_amz_object_lock_legal_hold
    ]
    def to_struct(headers, body) do
      headers |> Enum.reduce(%Response{body: body}, fn {key, value}, acc -> 
        key = key |> struct_key
        if(key |> is_nil, do: acc, else: %{acc | key => value})
      end)
    end
    defp struct_key(key) do
      case key do
        "x-amz-delete-marker" -> :x_amz_delete_marker
        "accept-ranges" -> :accept_ranges
        "x-amz-expiration" -> :x_amz_expiration
        "x-amz-restore:" -> :x_amz_restore
        "Last-Modified" -> :last_modified
        "Content-Length" -> :content_length
        "ETag" -> :e_tag
        "x-amz-missing-meta" -> :x_amz_missing_meta
        "x-amz-version-id" -> :x_amz_version_id
        "Cache-Control" -> :cache_control
        "Content-Disposition" -> :content_disposition
        "Content-Encoding" -> :content_encoding
        "Content-Language" -> :content_language
        "Content-Range" -> :content_range
        "Content-Type" -> :content_type
        "Expires" -> :expires
        "x-amz-website-redirect-location" -> :x_amz_website_redirect_location
        "x-amz-server-side-encryption" -> :x_amz_server_side_encryption
        "x-amz-server-side-encryption-customer-algorithm" -> :x_amz_server_side_encryption_customer_algorithm
        "x-amz-server-side-encryption-customer-key-MD5" -> :x_amz_server_side_encryption_customer_key_md5
        "x-amz-server-side-encryption-aws-kms-key-id" -> :x_amz_server_side_encryption_aws_kms_key_id
        "x-amz-storage-class" -> :x_amz_storage_class
        "x-amz-request-charged" -> :x_amz_request_charged
        "x-amz-replication-status" -> :x_amz_replication_status
        "x-amz-mp-parts-count" -> :x_amz_mp_parts_count
        "x-amz-tagging-count" -> :x_amz_tagging_count
        "x-amz-object-lock-mode" -> :x_amz_object_lock_mode
        "x-amz-object-lock-retain-until-date" -> :x_amz_object_lock_retain_until_date
        "x-amz-object-lock-legal-hold" -> :x_amz_object_lock_legal_hold
        _ -> nil
      end
    end
  end
end
