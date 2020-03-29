defmodule AwsErin.S3.Error do
  alias AwsErin.Xml

  @type t :: %__MODULE__{
    message: String.t,
    request_id: String.t,
    raw: String.t
  }
  defstruct [ :message, :request_id, :raw ]

  defmodule UnknownServerError, do: defstruct [ :message, :request_id, :raw ]
  defmodule AccessDenied, do: defstruct [ :message, :request_id, :raw ]
  defmodule AccountProblem, do: defstruct [ :message, :request_id, :raw ]
  defmodule AllAccessDisabled, do: defstruct [ :message, :request_id, :raw ]
  defmodule AmbiguousGrantByEmailAddress, do: defstruct [ :message, :request_id, :raw ]
  defmodule AuthorizationHeaderMalformed, do: defstruct [ :message, :request_id, :raw ]
  defmodule BadDigest, do: defstruct [ :message, :request_id, :raw ]
  defmodule BucketAlreadyExists, do: defstruct [ :message, :request_id, :raw ]
  defmodule BucketAlreadyOwnedByYou, do: defstruct [ :message, :request_id, :raw ]
  defmodule BucketNotEmpty, do: defstruct [ :message, :request_id, :raw ]
  defmodule CredentialsNotSupported, do: defstruct [ :message, :request_id, :raw ]
  defmodule CrossLocationLoggingProhibited, do: defstruct [ :message, :request_id, :raw ]
  defmodule EntityTooSmall, do: defstruct [ :message, :request_id, :raw ]
  defmodule EntityTooLarge, do: defstruct [ :message, :request_id, :raw ]
  defmodule ExpiredToken, do: defstruct [ :message, :request_id, :raw ]
  defmodule IllegalLocationConstraintExceptionIndicates, do: defstruct [ :message, :request_id, :raw ]
  defmodule IllegalVersioningConfigurationException, do: defstruct [ :message, :request_id, :raw ]
  defmodule IncompleteBody, do: defstruct [ :message, :request_id, :raw ]
  defmodule IncorrectNumberOfFilesInPostRequestPOST, do: defstruct [ :message, :request_id, :raw ]
  defmodule InlineDataTooLarge, do: defstruct [ :message, :request_id, :raw ]
  defmodule InternalError, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidAccessKeyId, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidAddressingHeader, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidArgument, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidBucketName, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidBucketState, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidDigest, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidEncryptionAlgorithmError, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidLocationConstraint, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidObjectState, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidPart, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidPartOrder, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidPayer, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidPolicyDocument, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidRange, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidRequest, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidSecurity, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidSOAPRequest, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidStorageClass, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidTargetBucketForLogging, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidToken, do: defstruct [ :message, :request_id, :raw ]
  defmodule InvalidURI, do: defstruct [ :message, :request_id, :raw ]
  defmodule KeyTooLongError, do: defstruct [ :message, :request_id, :raw ]
  defmodule MalformedACLError, do: defstruct [ :message, :request_id, :raw ]
  defmodule MalformedPOSTRequest, do: defstruct [ :message, :request_id, :raw ]
  defmodule MalformedXML, do: defstruct [ :message, :request_id, :raw ]
  defmodule MaxMessageLengthExceeded, do: defstruct [ :message, :request_id, :raw ]
  defmodule MaxPostPreDataLengthExceededErrorYour, do: defstruct [ :message, :request_id, :raw ]
  defmodule MetadataTooLarge, do: defstruct [ :message, :request_id, :raw ]
  defmodule MethodNotAllowed, do: defstruct [ :message, :request_id, :raw ]
  defmodule MissingAttachment, do: defstruct [ :message, :request_id, :raw ]
  defmodule MissingContentLength, do: defstruct [ :message, :request_id, :raw ]
  defmodule MissingRequestBodyError, do: defstruct [ :message, :request_id, :raw ]
  defmodule MissingSecurityElement, do: defstruct [ :message, :request_id, :raw ]
  defmodule MissingSecurityHeader, do: defstruct [ :message, :request_id, :raw ]
  defmodule NoLoggingStatusForKey, do: defstruct [ :message, :request_id, :raw ]
  defmodule NoSuchBucket, do: defstruct [ :message, :request_id, :raw ]
  defmodule NoSuchBucketPolicy, do: defstruct [ :message, :request_id, :raw ]
  defmodule NoSuchKey, do: defstruct [ :message, :request_id, :raw ]
  defmodule NoSuchLifecycleConfiguration, do: defstruct [ :message, :request_id, :raw ]
  defmodule NoSuchUpload, do: defstruct [ :message, :request_id, :raw ]
  defmodule NoSuchVersion, do: defstruct [ :message, :request_id, :raw ]
  defmodule NotImplemented, do: defstruct [ :message, :request_id, :raw ]
  defmodule NotSignedUp, do: defstruct [ :message, :request_id, :raw ]
  defmodule OperationAborted, do: defstruct [ :message, :request_id, :raw ]
  defmodule PermanentRedirect, do: defstruct [ :message, :request_id, :raw ]
  defmodule PreconditionFailed, do: defstruct [ :message, :request_id, :raw ]
  defmodule Redirect, do: defstruct [ :message, :request_id, :raw ]
  defmodule RestoreAlreadyInProgress, do: defstruct [ :message, :request_id, :raw ]
  defmodule RequestIsNotMultiPartContent, do: defstruct [ :message, :request_id, :raw ]
  defmodule RequestTimeout, do: defstruct [ :message, :request_id, :raw ]
  defmodule RequestTimeTooSkewed, do: defstruct [ :message, :request_id, :raw ]
  defmodule RequestTorrentOfBucketError, do: defstruct [ :message, :request_id, :raw ]
  defmodule ServerSideEncryptionConfigurationNotFoundError, do: defstruct [ :message, :request_id, :raw ]
  defmodule ServiceUnavailable, do: defstruct [ :message, :request_id, :raw ]
  defmodule SignatureDoesNotMatch, do: defstruct [ :message, :request_id, :raw ]
  defmodule SlowDown, do: defstruct [ :message, :request_id, :raw ]
  defmodule TemporaryRedirect, do: defstruct [ :message, :request_id, :raw ]
  defmodule TokenRefreshRequired, do: defstruct [ :message, :request_id, :raw ]
  defmodule TooManyBuckets, do: defstruct [ :message, :request_id, :raw ]
  defmodule UnexpectedContent, do: defstruct [ :message, :request_id, :raw ]
  defmodule UnresolvableGrantByEmailAddress, do: defstruct [ :message, :request_id, :raw ]
  defmodule UserKeyMustBeSpecified, do: defstruct [ :message, :request_id, :raw ]

  def to_error(status_code, xml) when xml |> is_binary do
    to_error(status_code, xml |> Xml.decode |> Map.get("Error"))
  end

  def to_error(301, %{"Code" => code, "Message" => message, "RequestId" => request_id} = error) do
    case code do
      "PermanentRedirect" -> %PermanentRedirect{message: message, request_id: request_id, raw: error |> inspect}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, raw: error |> inspect}
    end
  end

  def to_error(307, %{"Code" => code, "Message" => message, "RequestId" => request_id} = error) do
    case code do
      "Redirect" -> %Redirect{message: message, request_id: request_id, raw: error |> inspect}
      "TemporaryRedirect" -> %TemporaryRedirect{message: message, request_id: request_id, raw: error |> inspect}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, raw: error |> inspect}
    end
  end

  def to_error(400, %{"Code" => code, "Message" => message, "RequestId" => request_id} = error) do
    case code do
      "AmbiguousGrantByEmailAddress" -> %AmbiguousGrantByEmailAddress{message: message, request_id: request_id, raw: error |> inspect}
      "AuthorizationHeaderMalformed" -> %AuthorizationHeaderMalformed{message: message, request_id: request_id, raw: error |> inspect}
      "BadDigest" -> %BadDigest{message: message, request_id: request_id, raw: error |> inspect}
      "CredentialsNotSupported" -> %CredentialsNotSupported{message: message, request_id: request_id, raw: error |> inspect}
      "EntityTooSmall" -> %EntityTooSmall{message: message, request_id: request_id, raw: error |> inspect}
      "EntityTooLarge" -> %EntityTooLarge{message: message, request_id: request_id, raw: error |> inspect}
      "ExpiredToken" -> %ExpiredToken{message: message, request_id: request_id, raw: error |> inspect}
      "IllegalLocationConstraintExceptionIndicates" -> %IllegalLocationConstraintExceptionIndicates{message: message, request_id: request_id, raw: error |> inspect}
      "IllegalVersioningConfigurationException" -> %IllegalVersioningConfigurationException{message: message, request_id: request_id, raw: error |> inspect}
      "IncompleteBody" -> %IncompleteBody{message: message, request_id: request_id, raw: error |> inspect}
      "IncorrectNumberOfFilesInPostRequestPOST" -> %IncorrectNumberOfFilesInPostRequestPOST{message: message, request_id: request_id, raw: error |> inspect}
      "InlineDataTooLarge" -> %InlineDataTooLarge{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidArgument" -> %InvalidArgument{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidBucketName" -> %InvalidBucketName{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidDigest" -> %InvalidDigest{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidEncryptionAlgorithmError" -> %InvalidEncryptionAlgorithmError{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidLocationConstraint" -> %InvalidLocationConstraint{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidPart" -> %InvalidPart{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidPartOrder" -> %InvalidPartOrder{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidPolicyDocument" -> %InvalidPolicyDocument{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidRequest" -> %InvalidRequest{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidSOAPRequest" -> %InvalidSOAPRequest{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidStorageClass" -> %InvalidStorageClass{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidTargetBucketForLogging" -> %InvalidTargetBucketForLogging{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidToken" -> %InvalidToken{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidURI" -> %InvalidURI{message: message, request_id: request_id, raw: error |> inspect}
      "KeyTooLongError" -> %KeyTooLongError{message: message, request_id: request_id, raw: error |> inspect}
      "MalformedACLError" -> %MalformedACLError{message: message, request_id: request_id, raw: error |> inspect}
      "MalformedPOSTRequest" -> %MalformedPOSTRequest{message: message, request_id: request_id, raw: error |> inspect}
      "MalformedXML" -> %MalformedXML{message: message, request_id: request_id, raw: error |> inspect}
      "MaxMessageLengthExceeded" -> %MaxMessageLengthExceeded{message: message, request_id: request_id, raw: error |> inspect}
      "MaxPostPreDataLengthExceededErrorYour" -> %MaxPostPreDataLengthExceededErrorYour{message: message, request_id: request_id, raw: error |> inspect}
      "MetadataTooLarge" -> %MetadataTooLarge{message: message, request_id: request_id, raw: error |> inspect}
      "MissingRequestBodyError" -> %MissingRequestBodyError{message: message, request_id: request_id, raw: error |> inspect}
      "MissingSecurityElement" -> %MissingSecurityElement{message: message, request_id: request_id, raw: error |> inspect}
      "MissingSecurityHeader" -> %MissingSecurityHeader{message: message, request_id: request_id, raw: error |> inspect}
      "NoLoggingStatusForKey" -> %NoLoggingStatusForKey{message: message, request_id: request_id, raw: error |> inspect}
      "RequestIsNotMultiPartContent" -> %RequestIsNotMultiPartContent{message: message, request_id: request_id, raw: error |> inspect}
      "RequestTimeout" -> %RequestTimeout{message: message, request_id: request_id, raw: error |> inspect}
      "RequestTorrentOfBucketError" -> %RequestTorrentOfBucketError{message: message, request_id: request_id, raw: error |> inspect}
      "ServerSideEncryptionConfigurationNotFoundError" -> %ServerSideEncryptionConfigurationNotFoundError{message: message, request_id: request_id, raw: error |> inspect}
      "TokenRefreshRequired" -> %TokenRefreshRequired{message: message, request_id: request_id, raw: error |> inspect}
      "TooManyBuckets" -> %TooManyBuckets{message: message, request_id: request_id, raw: error |> inspect}
      "UnexpectedContent" -> %UnexpectedContent{message: message, request_id: request_id, raw: error |> inspect}
      "UnresolvableGrantByEmailAddress" -> %UnresolvableGrantByEmailAddress{message: message, request_id: request_id, raw: error |> inspect}
      "UserKeyMustBeSpecified" -> %UserKeyMustBeSpecified{message: message, request_id: request_id, raw: error |> inspect}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, raw: error |> inspect}
    end
  end

  def to_error(403, %{"Code" => code, "Message" => message, "RequestId" => request_id} = error) do
    case code do
      "AccessDenied" -> %AccessDenied{message: message, request_id: request_id, raw: error |> inspect}
      "AccountProblem" -> %AccountProblem{message: message, request_id: request_id, raw: error |> inspect}
      "AllAccessDisabled" -> %AllAccessDisabled{message: message, request_id: request_id, raw: error |> inspect}
      "CrossLocationLoggingProhibited" -> %CrossLocationLoggingProhibited{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidAccessKeyId" -> %InvalidAccessKeyId{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidObjectState" -> %InvalidObjectState{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidPayer" -> %InvalidPayer{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidSecurity" -> %InvalidSecurity{message: message, request_id: request_id, raw: error |> inspect}
      "NotSignedUp" -> %NotSignedUp{message: message, request_id: request_id, raw: error |> inspect}
      "RequestTimeTooSkewed" -> %RequestTimeTooSkewed{message: message, request_id: request_id, raw: error |> inspect}
      "SignatureDoesNotMatch" -> %SignatureDoesNotMatch{message: message, request_id: request_id, raw: error |> inspect}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, raw: error |> inspect}
    end
  end

  def to_error(404, %{"Code" => code, "Message" => message, "RequestId" => request_id} = error) do
    case code do
      "NoSuchBucket" -> %NoSuchBucket{message: message, request_id: request_id, raw: error |> inspect}
      "NoSuchBucketPolicy" -> %NoSuchBucketPolicy{message: message, request_id: request_id, raw: error |> inspect}
      "NoSuchKey" -> %NoSuchKey{message: message, request_id: request_id, raw: error |> inspect}
      "NoSuchLifecycleConfiguration" -> %NoSuchLifecycleConfiguration{message: message, request_id: request_id, raw: error |> inspect}
      "NoSuchUpload" -> %NoSuchUpload{message: message, request_id: request_id, raw: error |> inspect}
      "NoSuchVersion" -> %NoSuchVersion{message: message, request_id: request_id, raw: error |> inspect}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, raw: error |> inspect}
    end
  end

  def to_error(405, %{"Code" => code, "Message" => message, "RequestId" => request_id} = error) do
    case code do
      "MethodNotAllowed" -> %MethodNotAllowed{message: message, request_id: request_id, raw: error |> inspect}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, raw: error |> inspect}
    end
  end

  def to_error(409, %{"Code" => code, "Message" => message, "RequestId" => request_id} = error) do
    case code do
      "BucketAlreadyExists" -> %BucketAlreadyExists{message: message, request_id: request_id, raw: error |> inspect}
      "BucketAlreadyOwnedByYou" -> %BucketAlreadyOwnedByYou{message: message, request_id: request_id, raw: error |> inspect}
      "BucketNotEmpty" -> %BucketNotEmpty{message: message, request_id: request_id, raw: error |> inspect}
      "InvalidBucketState" -> %InvalidBucketState{message: message, request_id: request_id, raw: error |> inspect}
      "OperationAborted" -> %OperationAborted{message: message, request_id: request_id, raw: error |> inspect}
      "RestoreAlreadyInProgress" -> %RestoreAlreadyInProgress{message: message, request_id: request_id, raw: error |> inspect}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, raw: error |> inspect}
    end
  end

  def to_error(411, %{"Code" => code, "Message" => message, "RequestId" => request_id} = error) do
    case code do
      "MissingContentLength" -> %MissingContentLength{message: message, request_id: request_id, raw: error |> inspect}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, raw: error |> inspect}
    end
  end

  def to_error(412, %{"Code" => code, "Message" => message, "RequestId" => request_id} = error) do
    case code do
      "PreconditionFailed" -> %PreconditionFailed{message: message, request_id: request_id, raw: error |> inspect}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, raw: error |> inspect}
    end
  end

  def to_error(416, %{"Code" => code, "Message" => message, "RequestId" => request_id} = error) do
    case code do
      "InvalidRange" -> %InvalidRange{message: message, request_id: request_id, raw: error |> inspect}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, raw: error |> inspect}
    end
  end

  def to_error(500, %{"Code" => code, "Message" => message, "RequestId" => request_id} = error) do
    case code do
      "InternalError" -> %InternalError{message: message, request_id: request_id, raw: error |> inspect}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, raw: error |> inspect}
    end
  end

  def to_error(501, %{"Code" => code, "Message" => message, "RequestId" => request_id} = error) do
    case code do
      "NotImplemented" -> %NotImplemented{message: message, request_id: request_id, raw: error |> inspect}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, raw: error |> inspect}
    end
  end

  def to_error(503, %{"Code" => code, "Message" => message, "RequestId" => request_id} = error) do
    case code do
      "ServiceUnavailable" -> %ServiceUnavailable{message: message, request_id: request_id, raw: error |> inspect}
      "SlowDown" -> %SlowDown{message: message, request_id: request_id, raw: error |> inspect}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, raw: error |> inspect}
    end
  end

  def to_error(_status_code, %{"Code" => code, "Message" => message, "RequestId" => request_id} = error) do
    case code do
      "InvalidAddressingHeader" -> %InvalidAddressingHeader{message: message, request_id: request_id, raw: error |> inspect}
      "MissingAttachment" -> %MissingAttachment{message: message, request_id: request_id, raw: error |> inspect}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, raw: error |> inspect}
    end
  end

end
