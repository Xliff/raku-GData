use v6.c;

use GLib::Raw::Definitions;

unit package GData::Raw::Enums;

constant GDataBatchOperationType is export := guint32;
our enum GDataBatchOperationTypeEnum is export <
  GDATA_BATCH_OPERATION_QUERY
  GDATA_BATCH_OPERATION_INSERTION
  GDATA_BATCH_OPERATION_UPDATE
  GDATA_BATCH_OPERATION_DELETION
>;

constant GDataDocumentsServiceError is export := guint32;
our enum GDataDocumentsServiceErrorEnum is export <
  GDATA_DOCUMENTS_SERVICE_ERROR_INVALID_CONTENT_TYPE
>;

constant GDataLogLevel is export := guint32;
our enum GDataLogLevelEnum is export <
  GDATA_LOG_NONE
  GDATA_LOG_MESSAGES
  GDATA_LOG_HEADERS
  GDATA_LOG_FULL
  GDATA_LOG_FULL_UNREDACTED
>;

constant GDataMediaExpression is export := guint32;
our enum GDataMediaExpressionEnum is export <
  GDATA_MEDIA_EXPRESSION_SAMPLE
  GDATA_MEDIA_EXPRESSION_FULL
  GDATA_MEDIA_EXPRESSION_NONSTOP
>;

constant GDataMediaMedium is export := guint32;
our enum GDataMediaMediumEnum is export <
  GDATA_MEDIA_UNKNOWN
  GDATA_MEDIA_IMAGE
  GDATA_MEDIA_AUDIO
  GDATA_MEDIA_VIDEO
  GDATA_MEDIA_DOCUMENT
  GDATA_MEDIA_EXECUTABLE
>;

constant GDataOperationType is export := guint32;
our enum GDataOperationTypeEnum is export <
  GDATA_OPERATION_QUERY
  GDATA_OPERATION_INSERTION
  GDATA_OPERATION_UPDATE
  GDATA_OPERATION_DELETION
  GDATA_OPERATION_DOWNLOAD
  GDATA_OPERATION_UPLOAD
  GDATA_OPERATION_AUTHENTICATION
  GDATA_OPERATION_BATCH
>;

constant GDataParserError is export := guint32;
our enum GDataParserErrorEnum is export <
  GDATA_PARSER_ERROR_PARSING_STRING
  GDATA_PARSER_ERROR_EMPTY_DOCUMENT
>;

constant GDataParserOptions is export := guint32;
our enum GDataParserOptionsEnum is export <
  P_NONE
  P_NO_DUPES
  P_REQUIRED
  P_NON_EMPTY
  P_DEFAULT
  P_IGNORE_ERROR
>;

constant GDataPicasaWebVisibility is export := guint32;
our enum GDataPicasaWebVisibilityEnum is export <
  GDATA_PICASAWEB_PUBLIC
  GDATA_PICASAWEB_PRIVATE
>;

constant GDataQueryPaginationType is export := guint32;
our enum GDataQueryPaginationTypeEnum is export <
  GDATA_QUERY_PAGINATION_INDEXED
  GDATA_QUERY_PAGINATION_URIS
  GDATA_QUERY_PAGINATION_TOKENS
>;

constant GDataServiceError is export := guint32;
our enum GDataServiceErrorEnum is export <
  GDATA_SERVICE_ERROR_UNAVAILABLE
  GDATA_SERVICE_ERROR_PROTOCOL_ERROR
  GDATA_SERVICE_ERROR_ENTRY_ALREADY_INSERTED
  GDATA_SERVICE_ERROR_AUTHENTICATION_REQUIRED
  GDATA_SERVICE_ERROR_NOT_FOUND
  GDATA_SERVICE_ERROR_CONFLICT
  GDATA_SERVICE_ERROR_FORBIDDEN
  GDATA_SERVICE_ERROR_BAD_QUERY_PARAMETER
  GDATA_SERVICE_ERROR_NETWORK_ERROR
  GDATA_SERVICE_ERROR_PROXY_ERROR
  GDATA_SERVICE_ERROR_WITH_BATCH_OPERATION
  GDATA_SERVICE_ERROR_API_QUOTA_EXCEEDED
>;

constant GDataYouTubeAge is export := guint32;
our enum GDataYouTubeAgeEnum is export <
  GDATA_YOUTUBE_AGE_ALL_TIME
  GDATA_YOUTUBE_AGE_TODAY
  GDATA_YOUTUBE_AGE_THIS_WEEK
  GDATA_YOUTUBE_AGE_THIS_MONTH
>;

constant GDataYouTubePermission is export := guint32;
our enum GDataYouTubePermissionEnum is export <
  GDATA_YOUTUBE_PERMISSION_ALLOWED
  GDATA_YOUTUBE_PERMISSION_DENIED
  GDATA_YOUTUBE_PERMISSION_MODERATED
>;

constant GDataYouTubeSafeSearch is export := guint32;
our enum GDataYouTubeSafeSearchEnum is export <
  GDATA_YOUTUBE_SAFE_SEARCH_NONE
  GDATA_YOUTUBE_SAFE_SEARCH_MODERATE
  GDATA_YOUTUBE_SAFE_SEARCH_STRICT
>;

constant GDataYouTubeServiceError is export := guint32;
our enum GDataYouTubeServiceErrorEnum is export <
  GDATA_YOUTUBE_SERVICE_ERROR_API_QUOTA_EXCEEDED
  GDATA_YOUTUBE_SERVICE_ERROR_ENTRY_QUOTA_EXCEEDED
  GDATA_YOUTUBE_SERVICE_ERROR_CHANNEL_REQUIRED
>;

constant GDataYouTubeStandardFeedType is export := guint32;
our enum GDataYouTubeStandardFeedTypeEnum is export <
  GDATA_YOUTUBE_MOST_POPULAR_FEED
>;
