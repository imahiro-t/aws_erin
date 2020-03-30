defmodule AwsErin.S3.ListObjects do
  alias AwsErin.S3.Behaviour
  alias AwsErin.Xml

  defmodule ListBucketResult do
    @type t :: %__MODULE__{
      is_truncated: boolean,
      contents: list(Content.t),
      name: String.t,
      prefix: String.t,
      delimiter: String.t,
      max_keys: integer,
      common_prefixes: list(CommonPrefix.t),
      encoding_type: String.t,
      key_count: integer,
      continuation_token: String.t,
      next_continuation_token: String.t,
      start_after: String.t
    }
    defstruct [
      :is_truncated,
      :contents,
      :name,
      :prefix,
      :delimiter,
      :max_keys,
      :common_prefixes,
      :encoding_type,
      :key_count,
      :continuation_token,
      :next_continuation_token,
      :start_after
    ]
  end

  defmodule Content do
    @type t :: %__MODULE__{
      e_tag: String.t,
      key: String.t,
      last_modified: String.t,
      owner: Owner.t,
      size: integer,
      storage_class: String.t
    }
    defstruct [
      :e_tag,
      :key,
      :last_modified,
      :owner,
      :size,
      :storage_class
    ]
  end

  defmodule Owner do
    @type t :: %__MODULE__{
      display_name: String.t,
      id: String.t
    }
    defstruct [
      :display_name,
      :id
    ]
  end

  defmodule CommonPrefix do
    @type t :: %__MODULE__{
      prefix: String.t
    }
    defstruct [
      :prefix
    ]
  end

  defmodule Request do
    @behaviour Behaviour.Request
    @type t :: %__MODULE__{
      bucket: String.t,
      type: String.t,
      continuation_token: String.t,
      delimiter: String.t,
      encoding_type: String.t,
      fetch_owner: String.t,
      max_keys: String.t,
      prefix: String.t,
      start_after: String.t,
      x_amz_request_payer: String.t  
    }
    defstruct [
      :bucket,
      :type,
      :continuation_token,
      :delimiter,
      :encoding_type,
      :fetch_owner,
      :max_keys,
      :prefix,
      :start_after,
      :x_amz_request_payer
    ]
    def header_map(%Request{} = struct) do
      Map.new
      |> Behaviour.Request.put_map(struct, "x-amz-request-payer", :x_amz_request_payer)
    end
    def query_map(%Request{} = struct) do
      Map.new
      |> Behaviour.Request.put_map(struct, "type", :type)
      |> Behaviour.Request.put_map(struct, "continuation-token", :continuation_token)
      |> Behaviour.Request.put_map(struct, "delimiter", :delimiter)
      |> Behaviour.Request.put_map(struct, "encoding-type", :encoding_type)
      |> Behaviour.Request.put_map(struct, "fetch-owner", :fetch_owner)
      |> Behaviour.Request.put_map(struct, "max-keys", :max_keys)
      |> Behaviour.Request.put_map(struct, "prefix", :prefix)
      |> Behaviour.Request.put_map(struct, "start-after", :start_after)
    end
  end

  defmodule Response do
    @behaviour Behaviour.Response
    @type t :: %__MODULE__{
      list_bucket_result: ListBucketResult.t
    }
    defstruct [
      :list_bucket_result
    ]
    def to_struct(_headers, body) do
      map = body |> Xml.decode |> Map.get("ListBucketResult")
      contents = map |> Map.get("Contents", [])
      common_prefixes = map |> Map.get("CommonPrefixes", [])
      list_bucket_result = %ListBucketResult{
        is_truncated: map |> Map.get("IsTruncated", "false") |> String.downcase |> String.to_atom,
        contents: contents |> Enum.map(&to_content/1),
        name: map |> Map.get("Name"),
        prefix: map |> Map.get("Prefix"),
        delimiter: map |> Map.get("Delimiter"),
        max_keys: map |> Map.get("MaxKeys", "0") |> String.to_integer,
        common_prefixes: common_prefixes |> Enum.map(&to_common_prefix/1),
        encoding_type: map |> Map.get("EncodingType"),
        key_count: map |> Map.get("KeyCount", "0") |> String.to_integer,
        continuation_token: map |> Map.get("ContinuationToken"),
        next_continuation_token: map |> Map.get("NextContinuationToken"),
        start_after: map |> Map.get("StartAfter")
      }
      %Response{
        list_bucket_result: list_bucket_result
      }
    end
    defp to_content(map) do
      %Content{
        e_tag: map |> Map.get("ETag"),
        key: map |> Map.get("Key"),
        last_modified: map |> Map.get("LastModified"),
        owner: map |> Map.get("Owner") |> to_owner,
        size: map |> Map.get("Size", "0") |> String.to_integer,
        storage_class: map |> Map.get("StorageClass")
      }
    end
    defp to_owner(nil), do: nil
    defp to_owner(map) do
      %Owner{
        display_name: map |> Map.get("DisplayName"),
        id: map |> Map.get("ID")
      }
    end
    defp to_common_prefix(map) do
      %CommonPrefix{
        prefix: map |> Map.get("Prefix")
      }
    end
  end
end
