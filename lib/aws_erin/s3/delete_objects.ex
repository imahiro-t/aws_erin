defmodule AwsErin.S3.DeleteObjects do
  alias AwsErin.S3.Behaviour
  alias AwsErin.Xml

  defmodule DeleteObjects do
    @type t :: %__MODULE__{
      objects: list(DeleteObject.t),
      quiet: boolean
    }
    defstruct [
      :objects,
      :quiet
    ]
  end

  defmodule DeleteObject do
    @type t :: %__MODULE__{
      key: String.t,
      version_id: String.t
    }
    defstruct [
      :key,
      :version_id
    ]
  end

  defmodule DeleteResult do
    @type t :: %__MODULE__{
      deleted_objects: list(DeletedObject.t),
      error_objects: list(ErrorObject.t)
    }
    defstruct [
      :deleted_objects,
      :error_objects
    ]
  end

  defmodule DeletedObject do
    @type t :: %__MODULE__{
      key: String.t,
      version_id: String.t,
      delete_marker: String.t,
      delete_marker_version_id: String.t
    }
    defstruct [
      :key,
      :version_id,
      :delete_marker,
      :delete_marker_version_id
    ]
  end

  defmodule ErrorObject do
    @type t :: %__MODULE__{
      key: String.t,
      version_id: String.t,
      code: String.t,
      message: String.t
    }
    defstruct [
      :key,
      :version_id,
      :code,
      :message
    ]
  end

  defmodule Request do
    @behaviour Behaviour.Request
    @type t :: %__MODULE__{
      bucket: String.t,
      delete_objects: DeleteObjects.t,
      x_amz_mfa: String.t,
      x_amz_request_payer: String.t,
      x_amz_bypass_governance_retention: String.t
    }
    defstruct [
      :bucket,
      :delete_objects,
      :x_amz_mfa,
      :x_amz_request_payer,
      :x_amz_bypass_governance_retention
    ]
    def header_map(%Request{} = struct) do
      Map.new
      |> Behaviour.Request.put_map(struct, "x-amz-mfa", :x_amz_mfa)
      |> Behaviour.Request.put_map(struct, "x-amz-request-payer", :x_amz_request_payer)
      |> Behaviour.Request.put_map(struct, "x-amz-bypass-governance-retention", :x_amz_bypass_governance_retention)
    end
    def query_map(%Request{} = _struct) do
      %{"delete" => ""}
    end
    def body(%Request{} = struct) do
      prefix = ~s|<Delete>|
      suffix = ~s|</Delete>|
      if (struct.delete_objects |> is_nil) do
        prefix <> suffix
      else
        object = struct.delete_objects.objects
        |> Enum.map(fn %{key: key, version_id: version_id} -> 
          if (version_id |> is_nil) do
            "<Object><Key>#{key}</Key></Object>" 
          else
            "<Object><Key>#{key}</Key><VersionId>#{version_id}</VersionId></Object>"
          end
        end)
        |> Enum.join
        quiet = if(struct.delete_objects.quiet |> is_nil, do: "", else: "<Quiet>#{struct.delete_objects.quiet}</Quiet>")
        prefix <> object <> quiet <> suffix
      end
    end
  end

  defmodule Response do
    @behaviour Behaviour.Response
    @type t :: %__MODULE__{
      delete_result: DeleteResult.t,
      x_amz_request_charged: String.t
    }
    defstruct [
      :delete_result,
      :x_amz_request_charged
    ]
    def to_struct(headers, body) do
      delete_result_map = body |> Xml.decode |> Map.get("DeleteResult")
      deleted = delete_result_map |> Map.get("Deleted", [])
      error = delete_result_map |> Map.get("Error", [])
      delete_result = %DeleteResult{
        deleted_objects: deleted |> Enum.map(&to_deleted_object/1),
        error_objects: error |> Enum.map(&to_error_object/1)
      }
      headers |> Enum.reduce(%Response{delete_result: delete_result}, fn {key, value}, acc -> 
        key = key |> struct_key
        if(key |> is_nil, do: acc, else: %{acc | key => value})
      end)
    end
    defp to_deleted_object(map) do
      %DeletedObject{
        key: map |> Map.get("Key"),
        version_id: map |> Map.get("VersionId"),
        delete_marker: map |> Map.get("DeleteMarker"),
        delete_marker_version_id: map |> Map.get("DeleteMarkerVersionId")
      }
    end
    defp to_error_object(map) do
      %ErrorObject{
        key: map |> Map.get("Key"),
        version_id: map |> Map.get("VersionId"),
        code: map |> Map.get("Code"),
        message: map |> Map.get("Message")
      }
    end
    defp struct_key(key) do
      case key do
        "x-amz-request-charged" -> :x_amz_request_charged
        _ -> nil
      end
    end
  end
end
