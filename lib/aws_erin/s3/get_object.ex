defmodule AwsErin.S3.GetObject do
  alias AwsErin.S3.Behaviour

  defmodule Request do
    @behaviour Behaviour.Request
    defstruct [
      :bucket,
      :if_match,
      :if_modified_since,
      :if_none_match,
      :if_unmodified_since,
      :key,
      :part_number,
      :range,
      :response_cache_control,
      :response_content_disposition,
      :response_content_encoding,
      :response_content_language,
      :response_content_type,
      :response_expires,
      :version_id,
      :x_amz_request_payer,
      :x_amz_server_side_encryption_customer_algorithm,
      :x_amz_server_side_encryption_customer_key,
      :x_amz_server_side_encryption_customer_key_md5
    ]
    def header_map(%{} = map, %Request{} = struct) do
      map = if(struct.if_match |> is_nil, do: map, else: map |> Map.put("If-Match", struct.if_match))
      map = if(struct.if_modified_since |> is_nil, do: map, else: map |> Map.put("If-Modified-Since", struct.if_modified_since))
      map = if(struct.if_none_match |> is_nil, do: map, else: map |> Map.put("If-None-Match", struct.if_none_match))
      map = if(struct.if_unmodified_since |> is_nil, do: map, else: map |> Map.put("If-Unmodified-Since", struct.if_unmodified_since))
      map = if(struct.range |> is_nil, do: map, else: map |> Map.put("Range", struct.range))
      map = if(struct.x_amz_server_side_encryption_customer_algorithm |> is_nil, do: map, else: map |> Map.put("x-amz-server-side-encryption-customer-algorithm", struct.x_amz_server_side_encryption_customer_algorithm))
      map = if(struct.x_amz_server_side_encryption_customer_key |> is_nil, do: map, else: map |> Map.put("x-amz-server-side-encryption-customer-key", struct.x_amz_server_side_encryption_customer_key))
      map = if(struct.x_amz_server_side_encryption_customer_key_md5 |> is_nil, do: map, else: map |> Map.put("x-amz-server-side-encryption-customer-key-MD5", struct.x_amz_server_side_encryption_customer_key_md5))
      map = if(struct.x_amz_request_payer |> is_nil, do: map, else: map |> Map.put("x-amz-request-payer", struct.x_amz_request_payer))
      map
    end
    def query_map(%{} = map, %Request{} = struct) do
      map = if(struct.part_number |> is_nil, do: map, else: map |> Map.put("PartNumber", struct.part_number))
      map = if(struct.response_cache_control |> is_nil, do: map, else: map |> Map.put("ResponseCacheControl", struct.response_cache_control))
      map = if(struct.response_content_disposition |> is_nil, do: map, else: map |> Map.put("ResponseContentDisposition", struct.response_content_disposition))
      map = if(struct.response_content_encoding |> is_nil, do: map, else: map |> Map.put("ResponseContentEncoding", struct.response_content_encoding))
      map = if(struct.response_content_language |> is_nil, do: map, else: map |> Map.put("ResponseContentLanguage", struct.response_content_language))
      map = if(struct.response_content_type |> is_nil, do: map, else: map |> Map.put("ResponseContentType", struct.response_content_type))
      map = if(struct.response_expires |> is_nil, do: map, else: map |> Map.put("ResponseExpires", struct.response_expires))
      map = if(struct.version_id |> is_nil, do: map, else: map |> Map.put("VersionId", struct.version_id))
      map
    end
  end

  defmodule Response do
    @behaviour Behaviour.Response
    defstruct [
      :body,
      :accept_ranges,
      :cache_control,
      :content_disposition,
      :content_encoding,
      :content_language,
      :content_range,
      :content_type,
      :e_tag,
      :expires,
      :last_modified,
      :x_amz_delete_marker,
      :x_amz_expiration,
      :x_amz_missing_meta,
      :x_amz_mp_parts_count,
      :x_amz_object_lock_legal_hold,
      :x_amz_object_lock_mode,
      :x_amz_object_lock_retain_until_date,
      :x_amz_replication_status,
      :x_amz_request_charged,
      :x_amz_restore,
      :x_amz_server_side_encryption,
      :x_amz_server_side_encryption_aws_kms_key_id,
      :x_amz_server_side_encryption_customer_algorithm,
      :x_amz_server_side_encryption_customer_key_md5,
      :x_amz_storage_class,
      :x_amz_tagging_count,
      :x_amz_version_id,
      :x_amz_website_redirect_location
    ]
    def to_struct(headers, body) do
      headers |> Enum.reduce(%Response{body: body}, fn {key, value}, acc -> 
        key = key |> struct_key
        if(key |> is_nil, do: acc, else: %{acc | key => value})
      end)
    end
    defp struct_key(key) do
      case key do
        "accept-ranges" -> :accept_ranges
        "Cache-Control" -> :cache_control
        "Content-Disposition" -> :content_disposition
        "Content-Encoding" -> :content_encoding
        "Content-Language" -> :content_language
        "Content-Range" -> :content_range
        "Content-Type" -> :content_type
        "ETag" -> :e_tag
        "Expires" -> :expires
        "Last-Modified" -> :last_modified
        "x-amz-delete-marker" -> :x_amz_delete_marker
        "x-amz-expiration" -> :x_amz_expiration
        "x-amz-missing-meta" -> :x_amz_missing_meta
        "x-amz-mp-parts-count" -> :x_amz_mp_parts_count
        "x-amz-object-lock-legal-hold" -> :x_amz_object_lock_legal_hold
        "x-amz-object-lock-mode" -> :x_amz_object_lock_mode
        "x-amz-object-lock-retain-until-date" -> :x_amz_object_lock_retain_until_date
        "x-amz-replication-status" -> :x_amz_replication_status
        "x-amz-request-charged" -> :x_amz_request_charged
        "x-amz-restore:" -> :x_amz_restore
        "x-amz-server-side-encryption" -> :x_amz_server_side_encryption
        "x-amz-server-side-encryption-aws-kms-key-id" -> :x_amz_server_side_encryption_aws_kms_key_id
        "x-amz-server-side-encryption-customer-algorithm" -> :x_amz_server_side_encryption_customer_algorithm
        "x-amz-server-side-encryption-customer-key-MD5" -> :x_amz_server_side_encryption_customer_key_md5
        "x-amz-storage-class" -> :x_amz_storage_class
        "x-amz-tagging-count" -> :x_amz_tagging_count
        "x-amz-version-id" -> :x_amz_version_id
        "x-amz-website-redirect-location" -> :x_amz_website_redirect_location
        _ -> nil
      end
    end
  end
end
