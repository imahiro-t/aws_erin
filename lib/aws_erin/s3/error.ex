defmodule AwsErin.S3.Error do
  alias AwsErin.Xml

  defstruct [ :message, :request_id, :resource ]
  defmodule UnknownServerError, do: defstruct [ :message, :request_id, :resource ]
  defmodule AccessDenied, do: defstruct [ :message, :request_id, :resource ]
  defmodule AccountProblem, do: defstruct [ :message, :request_id, :resource ]
  defmodule AllAccessDisabled, do: defstruct [ :message, :request_id, :resource ]
  defmodule AmbiguousGrantByEmailAddress, do: defstruct [ :message, :request_id, :resource ]
  defmodule AuthorizationHeaderMalformed, do: defstruct [ :message, :request_id, :resource ]
  defmodule BadDigest, do: defstruct [ :message, :request_id, :resource ]
  defmodule BucketAlreadyExists, do: defstruct [ :message, :request_id, :resource ]
  defmodule BucketAlreadyOwnedByYou, do: defstruct [ :message, :request_id, :resource ]
  defmodule BucketNotEmpty, do: defstruct [ :message, :request_id, :resource ]
  defmodule CredentialsNotSupported, do: defstruct [ :message, :request_id, :resource ]
  defmodule CrossLocationLoggingProhibited, do: defstruct [ :message, :request_id, :resource ]
  defmodule EntityTooSmall, do: defstruct [ :message, :request_id, :resource ]
  defmodule EntityTooLarge, do: defstruct [ :message, :request_id, :resource ]
  defmodule ExpiredToken, do: defstruct [ :message, :request_id, :resource ]
  defmodule IllegalLocationConstraintExceptionIndicates, do: defstruct [ :message, :request_id, :resource ]
  defmodule IllegalVersioningConfigurationException, do: defstruct [ :message, :request_id, :resource ]
  defmodule IncompleteBody, do: defstruct [ :message, :request_id, :resource ]
  defmodule IncorrectNumberOfFilesInPostRequestPOST, do: defstruct [ :message, :request_id, :resource ]
  defmodule InlineDataTooLarge, do: defstruct [ :message, :request_id, :resource ]
  defmodule InternalError, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidAccessKeyId, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidAddressingHeader, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidArgument, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidBucketName, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidBucketState, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidDigest, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidEncryptionAlgorithmError, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidLocationConstraint, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidObjectState, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidPart, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidPartOrder, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidPayer, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidPolicyDocument, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidRange, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidRequest, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidSecurity, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidSOAPRequest, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidStorageClass, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidTargetBucketForLogging, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidToken, do: defstruct [ :message, :request_id, :resource ]
  defmodule InvalidURI, do: defstruct [ :message, :request_id, :resource ]
  defmodule KeyTooLongError, do: defstruct [ :message, :request_id, :resource ]
  defmodule MalformedACLError, do: defstruct [ :message, :request_id, :resource ]
  defmodule MalformedPOSTRequest, do: defstruct [ :message, :request_id, :resource ]
  defmodule MalformedXML, do: defstruct [ :message, :request_id, :resource ]
  defmodule MaxMessageLengthExceeded, do: defstruct [ :message, :request_id, :resource ]
  defmodule MaxPostPreDataLengthExceededErrorYour, do: defstruct [ :message, :request_id, :resource ]
  defmodule MetadataTooLarge, do: defstruct [ :message, :request_id, :resource ]
  defmodule MethodNotAllowed, do: defstruct [ :message, :request_id, :resource ]
  defmodule MissingAttachment, do: defstruct [ :message, :request_id, :resource ]
  defmodule MissingContentLength, do: defstruct [ :message, :request_id, :resource ]
  defmodule MissingRequestBodyError, do: defstruct [ :message, :request_id, :resource ]
  defmodule MissingSecurityElement, do: defstruct [ :message, :request_id, :resource ]
  defmodule MissingSecurityHeader, do: defstruct [ :message, :request_id, :resource ]
  defmodule NoLoggingStatusForKey, do: defstruct [ :message, :request_id, :resource ]
  defmodule NoSuchBucket, do: defstruct [ :message, :request_id, :resource ]
  defmodule NoSuchBucketPolicy, do: defstruct [ :message, :request_id, :resource ]
  defmodule NoSuchKey, do: defstruct [ :message, :request_id, :resource ]
  defmodule NoSuchLifecycleConfiguration, do: defstruct [ :message, :request_id, :resource ]
  defmodule NoSuchUpload, do: defstruct [ :message, :request_id, :resource ]
  defmodule NoSuchVersion, do: defstruct [ :message, :request_id, :resource ]
  defmodule NotImplemented, do: defstruct [ :message, :request_id, :resource ]
  defmodule NotSignedUp, do: defstruct [ :message, :request_id, :resource ]
  defmodule OperationAborted, do: defstruct [ :message, :request_id, :resource ]
  defmodule PermanentRedirect, do: defstruct [ :message, :request_id, :resource ]
  defmodule PreconditionFailed, do: defstruct [ :message, :request_id, :resource ]
  defmodule Redirect, do: defstruct [ :message, :request_id, :resource ]
  defmodule RestoreAlreadyInProgress, do: defstruct [ :message, :request_id, :resource ]
  defmodule RequestIsNotMultiPartContent, do: defstruct [ :message, :request_id, :resource ]
  defmodule RequestTimeout, do: defstruct [ :message, :request_id, :resource ]
  defmodule RequestTimeTooSkewed, do: defstruct [ :message, :request_id, :resource ]
  defmodule RequestTorrentOfBucketError, do: defstruct [ :message, :request_id, :resource ]
  defmodule ServerSideEncryptionConfigurationNotFoundError, do: defstruct [ :message, :request_id, :resource ]
  defmodule ServiceUnavailable, do: defstruct [ :message, :request_id, :resource ]
  defmodule SignatureDoesNotMatch, do: defstruct [ :message, :request_id, :resource ]
  defmodule SlowDown, do: defstruct [ :message, :request_id, :resource ]
  defmodule TemporaryRedirect, do: defstruct [ :message, :request_id, :resource ]
  defmodule TokenRefreshRequired, do: defstruct [ :message, :request_id, :resource ]
  defmodule TooManyBuckets, do: defstruct [ :message, :request_id, :resource ]
  defmodule UnexpectedContent, do: defstruct [ :message, :request_id, :resource ]
  defmodule UnresolvableGrantByEmailAddress, do: defstruct [ :message, :request_id, :resource ]
  defmodule UserKeyMustBeSpecified, do: defstruct [ :message, :request_id, :resource ]

  def to_error(status_code, xml) when xml |> is_binary do
    to_error(status_code, Xml.decode(xml) |> Map.get("Error"))
  end

  def to_error(301, %{"Code" => code, "Message" => message, "RequestId" => request_id, "Resource" => resource}) do
    case code do
      "PermanentRedirect" -> %PermanentRedirect{message: message, request_id: request_id, resource: resource}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, resource: resource}
    end
  end

  def to_error(307, %{"Code" => code, "Message" => message, "RequestId" => request_id, "Resource" => resource}) do
    case code do
      "Redirect" -> %Redirect{message: message, request_id: request_id, resource: resource}
      "TemporaryRedirect" -> %TemporaryRedirect{message: message, request_id: request_id, resource: resource}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, resource: resource}
    end
  end

  def to_error(400, %{"Code" => code, "Message" => message, "RequestId" => request_id, "Resource" => resource}) do
    case code do
      "AmbiguousGrantByEmailAddress" -> %AmbiguousGrantByEmailAddress{message: message, request_id: request_id, resource: resource}
      "AuthorizationHeaderMalformed" -> %AuthorizationHeaderMalformed{message: message, request_id: request_id, resource: resource}
      "BadDigest" -> %BadDigest{message: message, request_id: request_id, resource: resource}
      "CredentialsNotSupported" -> %CredentialsNotSupported{message: message, request_id: request_id, resource: resource}
      "EntityTooSmall" -> %EntityTooSmall{message: message, request_id: request_id, resource: resource}
      "EntityTooLarge" -> %EntityTooLarge{message: message, request_id: request_id, resource: resource}
      "ExpiredToken" -> %ExpiredToken{message: message, request_id: request_id, resource: resource}
      "IllegalLocationConstraintExceptionIndicates" -> %IllegalLocationConstraintExceptionIndicates{message: message, request_id: request_id, resource: resource}
      "IllegalVersioningConfigurationException" -> %IllegalVersioningConfigurationException{message: message, request_id: request_id, resource: resource}
      "IncompleteBody" -> %IncompleteBody{message: message, request_id: request_id, resource: resource}
      "IncorrectNumberOfFilesInPostRequestPOST" -> %IncorrectNumberOfFilesInPostRequestPOST{message: message, request_id: request_id, resource: resource}
      "InlineDataTooLarge" -> %InlineDataTooLarge{message: message, request_id: request_id, resource: resource}
      "InvalidArgument" -> %InvalidArgument{message: message, request_id: request_id, resource: resource}
      "InvalidBucketName" -> %InvalidBucketName{message: message, request_id: request_id, resource: resource}
      "InvalidDigest" -> %InvalidDigest{message: message, request_id: request_id, resource: resource}
      "InvalidEncryptionAlgorithmError" -> %InvalidEncryptionAlgorithmError{message: message, request_id: request_id, resource: resource}
      "InvalidLocationConstraint" -> %InvalidLocationConstraint{message: message, request_id: request_id, resource: resource}
      "InvalidPart" -> %InvalidPart{message: message, request_id: request_id, resource: resource}
      "InvalidPartOrder" -> %InvalidPartOrder{message: message, request_id: request_id, resource: resource}
      "InvalidPolicyDocument" -> %InvalidPolicyDocument{message: message, request_id: request_id, resource: resource}
      "InvalidRequest" -> %InvalidRequest{message: message, request_id: request_id, resource: resource}
      "InvalidSOAPRequest" -> %InvalidSOAPRequest{message: message, request_id: request_id, resource: resource}
      "InvalidStorageClass" -> %InvalidStorageClass{message: message, request_id: request_id, resource: resource}
      "InvalidTargetBucketForLogging" -> %InvalidTargetBucketForLogging{message: message, request_id: request_id, resource: resource}
      "InvalidToken" -> %InvalidToken{message: message, request_id: request_id, resource: resource}
      "InvalidURI" -> %InvalidURI{message: message, request_id: request_id, resource: resource}
      "KeyTooLongError" -> %KeyTooLongError{message: message, request_id: request_id, resource: resource}
      "MalformedACLError" -> %MalformedACLError{message: message, request_id: request_id, resource: resource}
      "MalformedPOSTRequest" -> %MalformedPOSTRequest{message: message, request_id: request_id, resource: resource}
      "MalformedXML" -> %MalformedXML{message: message, request_id: request_id, resource: resource}
      "MaxMessageLengthExceeded" -> %MaxMessageLengthExceeded{message: message, request_id: request_id, resource: resource}
      "MaxPostPreDataLengthExceededErrorYour" -> %MaxPostPreDataLengthExceededErrorYour{message: message, request_id: request_id, resource: resource}
      "MetadataTooLarge" -> %MetadataTooLarge{message: message, request_id: request_id, resource: resource}
      "MissingRequestBodyError" -> %MissingRequestBodyError{message: message, request_id: request_id, resource: resource}
      "MissingSecurityElement" -> %MissingSecurityElement{message: message, request_id: request_id, resource: resource}
      "MissingSecurityHeader" -> %MissingSecurityHeader{message: message, request_id: request_id, resource: resource}
      "NoLoggingStatusForKey" -> %NoLoggingStatusForKey{message: message, request_id: request_id, resource: resource}
      "RequestIsNotMultiPartContent" -> %RequestIsNotMultiPartContent{message: message, request_id: request_id, resource: resource}
      "RequestTimeout" -> %RequestTimeout{message: message, request_id: request_id, resource: resource}
      "RequestTorrentOfBucketError" -> %RequestTorrentOfBucketError{message: message, request_id: request_id, resource: resource}
      "ServerSideEncryptionConfigurationNotFoundError" -> %ServerSideEncryptionConfigurationNotFoundError{message: message, request_id: request_id, resource: resource}
      "TokenRefreshRequired" -> %TokenRefreshRequired{message: message, request_id: request_id, resource: resource}
      "TooManyBuckets" -> %TooManyBuckets{message: message, request_id: request_id, resource: resource}
      "UnexpectedContent" -> %UnexpectedContent{message: message, request_id: request_id, resource: resource}
      "UnresolvableGrantByEmailAddress" -> %UnresolvableGrantByEmailAddress{message: message, request_id: request_id, resource: resource}
      "UserKeyMustBeSpecified" -> %UserKeyMustBeSpecified{message: message, request_id: request_id, resource: resource}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, resource: resource}
    end
  end

  def to_error(403, %{"Code" => code, "Message" => message, "RequestId" => request_id, "Resource" => resource}) do
    case code do
      "AccessDenied" -> %AccessDenied{message: message, request_id: request_id, resource: resource}
      "AccountProblem" -> %AccountProblem{message: message, request_id: request_id, resource: resource}
      "AllAccessDisabled" -> %AllAccessDisabled{message: message, request_id: request_id, resource: resource}
      "CrossLocationLoggingProhibited" -> %CrossLocationLoggingProhibited{message: message, request_id: request_id, resource: resource}
      "InvalidAccessKeyId" -> %InvalidAccessKeyId{message: message, request_id: request_id, resource: resource}
      "InvalidObjectState" -> %InvalidObjectState{message: message, request_id: request_id, resource: resource}
      "InvalidPayer" -> %InvalidPayer{message: message, request_id: request_id, resource: resource}
      "InvalidSecurity" -> %InvalidSecurity{message: message, request_id: request_id, resource: resource}
      "NotSignedUp" -> %NotSignedUp{message: message, request_id: request_id, resource: resource}
      "RequestTimeTooSkewed" -> %RequestTimeTooSkewed{message: message, request_id: request_id, resource: resource}
      "SignatureDoesNotMatch" -> %SignatureDoesNotMatch{message: message, request_id: request_id, resource: resource}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, resource: resource}
    end
  end

  def to_error(404, %{"Code" => code, "Message" => message, "RequestId" => request_id, "Resource" => resource}) do
    case code do
      "NoSuchBucket" -> %NoSuchBucket{message: message, request_id: request_id, resource: resource}
      "NoSuchBucketPolicy" -> %NoSuchBucketPolicy{message: message, request_id: request_id, resource: resource}
      "NoSuchKey" -> %NoSuchKey{message: message, request_id: request_id, resource: resource}
      "NoSuchLifecycleConfiguration" -> %NoSuchLifecycleConfiguration{message: message, request_id: request_id, resource: resource}
      "NoSuchUpload" -> %NoSuchUpload{message: message, request_id: request_id, resource: resource}
      "NoSuchVersion" -> %NoSuchVersion{message: message, request_id: request_id, resource: resource}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, resource: resource}
    end
  end

  def to_error(405, %{"Code" => code, "Message" => message, "RequestId" => request_id, "Resource" => resource}) do
    case code do
      "MethodNotAllowed" -> %MethodNotAllowed{message: message, request_id: request_id, resource: resource}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, resource: resource}
    end
  end

  def to_error(409, %{"Code" => code, "Message" => message, "RequestId" => request_id, "Resource" => resource}) do
    case code do
      "BucketAlreadyExists" -> %BucketAlreadyExists{message: message, request_id: request_id, resource: resource}
      "BucketAlreadyOwnedByYou" -> %BucketAlreadyOwnedByYou{message: message, request_id: request_id, resource: resource}
      "BucketNotEmpty" -> %BucketNotEmpty{message: message, request_id: request_id, resource: resource}
      "InvalidBucketState" -> %InvalidBucketState{message: message, request_id: request_id, resource: resource}
      "OperationAborted" -> %OperationAborted{message: message, request_id: request_id, resource: resource}
      "RestoreAlreadyInProgress" -> %RestoreAlreadyInProgress{message: message, request_id: request_id, resource: resource}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, resource: resource}
    end
  end

  def to_error(411, %{"Code" => code, "Message" => message, "RequestId" => request_id, "Resource" => resource}) do
    case code do
      "MissingContentLength" -> %MissingContentLength{message: message, request_id: request_id, resource: resource}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, resource: resource}
    end
  end

  def to_error(412, %{"Code" => code, "Message" => message, "RequestId" => request_id, "Resource" => resource}) do
    case code do
      "PreconditionFailed" -> %PreconditionFailed{message: message, request_id: request_id, resource: resource}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, resource: resource}
    end
  end

  def to_error(416, %{"Code" => code, "Message" => message, "RequestId" => request_id, "Resource" => resource}) do
    case code do
      "InvalidRange" -> %InvalidRange{message: message, request_id: request_id, resource: resource}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, resource: resource}
    end
  end

  def to_error(500, %{"Code" => code, "Message" => message, "RequestId" => request_id, "Resource" => resource}) do
    case code do
      "InternalError" -> %InternalError{message: message, request_id: request_id, resource: resource}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, resource: resource}
    end
  end

  def to_error(501, %{"Code" => code, "Message" => message, "RequestId" => request_id, "Resource" => resource}) do
    case code do
      "NotImplemented" -> %NotImplemented{message: message, request_id: request_id, resource: resource}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, resource: resource}
    end
  end

  def to_error(503, %{"Code" => code, "Message" => message, "RequestId" => request_id, "Resource" => resource}) do
    case code do
      "ServiceUnavailable" -> %ServiceUnavailable{message: message, request_id: request_id, resource: resource}
      "SlowDown" -> %SlowDown{message: message, request_id: request_id, resource: resource}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, resource: resource}
    end
  end

  def to_error(_status_code, %{"Code" => code, "Message" => message, "RequestId" => request_id, "Resource" => resource}) do
    case code do
      "InvalidAddressingHeader" -> %InvalidAddressingHeader{message: message, request_id: request_id, resource: resource}
      "MissingAttachment" -> %MissingAttachment{message: message, request_id: request_id, resource: resource}
      _ -> %UnknownServerError{message: "#{code} #{message}", request_id: request_id, resource: resource}
    end
  end

end
