use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GLib::Raw::Subs;
use GIO::Raw::Definitions;
use GIO::Raw::Structs;
use GData::Raw::Definitions;
use GData::Raw::Enums;

unit package GData::Raw::Structs;

class GDataDummyAuthorizer is repr<CStruct> is export does StructSkipsTest['not compiled'] {
	HAS GObject  $!parent;
	has gpointer $!priv  ;
}

class GDataAuthorizationDomain is repr<CStruct> is export {
	HAS GObject  $!parent;
	has gpointer $!priv  ;
}

class GDataBatchOperation is repr<CStruct> is export {
	HAS GObject  $!parent;
	has gpointer $!priv  ;
}

class GDataService is repr<CStruct> is export {
	HAS GObject  $!parent;
	has gpointer $!priv  ;
}

class GDataAsyncProgressClosure is repr<CStruct> is export does StructSkipsTest['not compiled'] {
	has guint     $.progress_destroy_notify_count is rw;
	has guint     $.async_ready_notify_count      is rw;
	has GMainLoop $!main_loop                    ;
}

class GDataColor is repr<CStruct> is export {
	has guint16 $.red   is rw;
	has guint16 $.green is rw;
	has guint16 $.blue  is rw;
}

class GDataDownloadStream is repr<CStruct> is export {
	HAS GInputStream $!parent;
	has gpointer     $!priv  ;
}

class GDataParsable is repr<CStruct> is export {
	HAS GObject  $!parent;
	has gpointer $!priv  ;
}

# cw: Temporatily added for debugging!
class GDataEntryPrivate
	is   repr<CStruct>
	is   export
	does StructSkipsTest['internal']
{
  has Str                     $.title;
  has Str                     $.summary;
  has Str                     $.id;
  has Str                     $.etag;
  # has int64                   $.updated;
  # has int64                   $.published;
  # has GList                   $!categories;
  # has str                     $.content;
  # has gboolean                $.content_is_uri;
  # has GList 	                $!links;
  # has GList 	                $!authors;
  # has str                     $.rights;
  # has GDataBatchOperationType $.batch_operation_type;
  # has guint                   $.batch_id;
};


class GDataEntry is repr<CStruct> is export {
	HAS GDataParsable     $!parent;
	has GDataEntryPrivate $.priv  ;
}

class GDataFeed is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataQuery is repr<CStruct> is export {
	HAS GObject  $!parent;
	has gpointer $!priv  ;
}

class BatchOperation is repr<CStruct> is export does StructSkipsTest['not compiled']  {
	has guint                       $.id         is rw;
	has GDataBatchOperationType     $!type      ;
	has gpointer                    $!callback  ; #= GDataBatchOperationCallback
	has gpointer                    $!user_data ;
	has Str                         $!query_id  ;
	has GType                       $!entry_type;
	has GError                      $!error     ;
	has GDataEntry                  $!entry     ;
}

class GDataAPPCategories is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataAccessRule is repr<CStruct> is export {
	HAS GDataEntry $!parent;
	has gpointer   $!priv  ;
}

class GDataAsyncTestData is repr<CStruct> is export is StructSkipsTest['not compiled'] {
	has GMainLoop     $!main_loop              ;
	has GCancellable  $!cancellable            ;
	has guint         $.cancellation_timeout    is rw;
	has guint         $.cancellation_timeout_id is rw;
	has gboolean      $!cancellation_successful;
	has gconstpointer $!test_data              ;
}

class GDataAuthor is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataBatchFeed is repr<CStruct> is export is StructSkipsTest['not compiled'] {
	HAS GDataFeed $!parent;
	has gpointer  $!priv  ;
}

class GDataBuffer is repr<CStruct> is export does StructSkipsTest['not compiled']  {
	has GDataBufferChunk $!head            ;
	has gsize            $!head_read_offset;
	has gsize            $!total_length    ;
	has gboolean         $!reached_eof     ;
	has GDataBufferChunk $!tail            ;
	has GMutex           $!mutex           ;
	has GCond            $!cond            ;
}

class GDataCalendarAccessRule is repr<CStruct> is export {
	HAS GDataAccessRule $!parent;
}

class GDataCalendarCalendar is repr<CStruct> is export {
	HAS GDataEntry $!parent;
	has gpointer   $!priv  ;
}

class GDataCalendarEvent is repr<CStruct> is export {
	HAS GDataEntry $!parent;
	has gpointer   $!priv  ;
}

class GDataCalendarFeed is repr<CStruct> is export {
	HAS GDataFeed $!parent;
	has gpointer  $!priv  ;
}

class GDataCalendarQuery is repr<CStruct> is export {
	HAS GDataQuery $!parent;
	has gpointer   $!priv  ;
}

class GDataCalendarService is repr<CStruct> is export {
	HAS GDataService $!parent;
}

class GDataCategory is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataComment is repr<CStruct> is export {
	HAS GDataEntry $!parent;
	has gpointer   $!priv  ;
}

class GDataDocumentsAccessRule is repr<CStruct> is export {
	HAS GDataAccessRule $!parent;
}

class GDataDocumentsEntry is repr<CStruct> is export {
	HAS GDataEntry $!parent;
	has gpointer   $!priv  ;
}

class GDataDocumentsDocument is repr<CStruct> is export {
	HAS GDataDocumentsEntry $!parent;
	has gpointer            $!priv  ;
}

class GDataDocumentsDrawing is repr<CStruct> is export {
	HAS GDataDocumentsDocument $!parent;
	has gpointer               $!priv  ;
}

class GDataDocumentsUploadQuery is repr<CStruct> is export {
	HAS GObject  $!parent;
	has gpointer $!priv  ;
}

class GDataDocumentsFeed is repr<CStruct> is export {
	HAS GDataFeed $!parent;
	has gpointer  $!priv  ;
}

class GDataDocumentsFolder is repr<CStruct> is export {
	HAS GDataDocumentsEntry $!parent;
	has gpointer            $!priv  ;
}

class GDataDocumentsMetadata is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataDocumentsPdf is repr<CStruct> is export {
	HAS GDataDocumentsDocument $!parent;
	has gpointer               $!priv  ;
}

class GDataDocumentsPresentation is repr<CStruct> is export {
	HAS GDataDocumentsDocument $!parent;
	has gpointer               $!priv  ;
}

class GDataDocumentsProperty is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataDocumentsQuery is repr<CStruct> is export {
	HAS GDataQuery $!parent;
	has gpointer   $!priv  ;
}

class GDataDocumentsService is repr<CStruct> is export {
	HAS GDataService $!parent;
	has gpointer     $!priv  ;
}

class GDataDocumentsSpreadsheet is repr<CStruct> is export {
	HAS GDataDocumentsDocument $!parent;
	has gpointer               $!priv  ;
}

class GDataDocumentsText is repr<CStruct> is export {
	HAS GDataDocumentsDocument $!parent;
	has gpointer               $!priv  ;
}

class GDataExifTags is repr<CStruct> is export does StructSkipsTest['not compiled']  {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGContactCalendar is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGContactEvent is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGContactExternalID is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGContactJot is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGContactLanguage is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGContactRelation is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGContactWebsite is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGDEmailAddress is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGDFeedLink is repr<CStruct> is export does StructSkipsTest['not compiled']  {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGDIMAddress is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGDName is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGDOrganization is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGDPhoneNumber is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGDPostalAddress is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGDReminder is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGDWhen is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGDWhere is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGDWho is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGenerator is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGeoRSSWhere is repr<CStruct> is export does StructSkipsTest['not compiled']  {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataGoaAuthorizer is repr<CStruct> is export does StructSkipsTest['not compiled']  {
	HAS GObject  $!parent;
	has gpointer $!priv  ;
}

class GDataOAuth2Authorizer is repr<CStruct> is export {
	HAS GObject  $!parent;
	has gpointer $!priv  ;
}

class GDataLink is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataMediaCategory is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataMediaContent is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataMediaCredit is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataMediaGroup is repr<CStruct> is export does StructSkipsTest['not compiled']  {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataMediaThumbnail is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataPicasaWebAlbum is repr<CStruct> is export {
	HAS GDataEntry $!parent;
	has gpointer   $!priv  ;
}

class GDataPicasaWebComment is repr<CStruct> is export {
	HAS GDataComment $!parent;
	has gpointer     $!priv  ;
}

class GDataPicasaWebFeed is repr<CStruct> is export {
	HAS GDataFeed $!parent  ;
	has gpointer  $!padding1;
}

class GDataPicasaWebFile is repr<CStruct> is export {
	HAS GDataEntry $!parent;
	has gpointer   $!priv  ;
}

class GDataPicasaWebQuery is repr<CStruct> is export {
	HAS GDataQuery $!parent;
	has gpointer   $!priv  ;
}

class GDataPicasaWebService is repr<CStruct> is export {
	HAS GDataService $!parent;
}

class GDataPicasaWebUser is repr<CStruct> is export {
	HAS GDataEntry $!parent;
	has gpointer   $!priv  ;
}

class GDataTasksQuery is repr<CStruct> is export {
	HAS GDataQuery $!parent;
	has gpointer   $!priv  ;
}

class GDataTasksService is repr<CStruct> is export {
	HAS GDataService $!parent;
}

class GDataTasksTask is repr<CStruct> is export {
	HAS GDataEntry $!parent;
	has gpointer   $!priv  ;
}

class GDataTasksTasklist is repr<CStruct> is export {
	HAS GDataEntry $!parent;
}

class GDataUploadStream is repr<CStruct> is export {
	HAS GOutputStream $!parent;
	has gpointer      $!priv  ;
}

class GDataYouTubeCategory is repr<CStruct> is export {
	HAS GDataCategory $!parent;
	has gpointer      $!priv  ;
}

class GDataYouTubeComment is repr<CStruct> is export {
	HAS GDataComment $!parent;
	has gpointer     $!priv  ;
}

class GDataYouTubeFeed is repr<CStruct> is export {
	HAS GDataFeed $!parent;
	has gpointer  $!priv  ;
}

class GDataYouTubeQuery is repr<CStruct> is export {
	HAS GDataQuery $!parent;
	has gpointer   $!priv  ;
}

class GDataYouTubeService is repr<CStruct> is export {
	HAS GDataService $!parent;
	has gpointer     $!priv  ;
}

class GDataYouTubeState is repr<CStruct> is export {
	HAS GDataParsable $!parent;
	has gpointer      $!priv  ;
}

class GDataYouTubeVideo is repr<CStruct> is export {
	HAS GDataEntry $.parent;
	has gpointer   $!priv  ;
}
