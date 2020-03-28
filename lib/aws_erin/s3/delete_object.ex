defmodule AwsErin.S3.DeleteObject do
  alias AwsErin.S3.Behaviour

  defmodule Request do
    @behaviour Behaviour.Request
    defstruct [
      :bucket,
      :key,
      :version_id,
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
    def query_map(%Request{} = struct) do
      Map.new
      |> Behaviour.Request.put_map(struct, "VersionId", :version_id)
    end
  end

  defmodule Response do
    @behaviour Behaviour.Response
    defstruct [
      :x_amz_delete_marker,
      :x_amz_version_id,
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
        "x-amz-delete-marker" -> :x_amz_delete_marker
        "x-amz-version-id" -> :x_amz_version_id
        "x-amz-request-charged" -> :x_amz_request_charged
        _ -> nil
      end
    end
  end
end
