use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Enums;
use GData::Raw::Structs;

unit package GData::Raw::Youtube::Service;

### /usr/src/libgdata/gdata/services/youtube/gdata-youtube-service.h

sub gdata_youtube_service_error_quark
  returns GQuark
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_service_finish_video_upload (
  GDataYouTubeService     $self,
  GDataUploadStream       $upload_stream,
  CArray[Pointer[GError]] $error
)
  returns GDataYouTubeVideo
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_service_get_categories (
  GDataYouTubeService     $self,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDataAPPCategories
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_service_get_categories_async (
  GDataYouTubeService $self,
  GCancellable        $cancellable,
                      &callback (
                        GDataYoutubeService,
                        GAsyncResult,
                        gpointer
                      ),
  gpointer            $user_data
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_service_get_categories_finish (
  GDataYouTubeService     $self,
  GAsyncResult            $async_result,
  CArray[Pointer[GError]] $error
)
  returns GDataAPPCategories
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_service_get_developer_key (GDataYouTubeService $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_service_get_primary_authorization_domain
  returns GDataAuthorizationDomain
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_service_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_service_new (
  Str             $developer_key,
  GDataAuthorizer $authorizer
)
  returns GDataYouTubeService
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_service_query_related (
  GDataYouTubeService        $self,
  GDataYouTubeVideo          $video,
  GDataQuery                 $query,
  GCancellable               $cancellable,
                             &progress_callback(
                               GDataEntry,
                               guint
                               guint,
                               gpointer
                             ), #= GDataQueryProgressCallback
  gpointer                   $progress_user_data,
  CArray[Pointer[GError]]    $error
)
  returns GDataFeed
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_service_query_related_async (
  GDataYouTubeService $self,
  GDataYouTubeVideo   $video,
  GDataQuery          $query,
  GCancellable        $cancellable,
                      &progress_callback(
                        GDataEntry,
                        guint
                        guint,
                        gpointer
                      ), #= GDataQueryProgressCallback
  gpointer            $progress_user_data,
                      &destroy_progress_user_data (gpointer),
                      &callback (
                        GDataYoutubeService,
                        GAsyncResult,
                        gpointer
                      ),
  gpointer            $user_data
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_service_query_standard_feed (
  GDataYouTubeService          $self,
  GDataYouTubeStandardFeedType $feed_type,
  GDataQuery                   $query,
  GCancellable                 $cancellable,
                               &progress_callback(
                                 GDataEntry,
                                 guint
                                 guint,
                                 gpointer
                               ), #= GDataQueryProgressCallback
  gpointer                     $progress_user_data,
  CArray[Pointer[GError]]      $error
)
  returns GDataFeed
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_service_query_standard_feed_async (
  GDataYouTubeService          $self,
  GDataYouTubeStandardFeedType $feed_type,
  GDataQuery                   $query,
  GCancellable                 $cancellable,
                               &progress_callback(
                                 GDataEntry,
                                 guint
                                 guint,
                                 gpointer
                               ), #= GDataQueryProgressCallback
  gpointer                     $progress_user_data,
                               &destroy_progress_user_data (gpointer),
                               &callback (
                                 GDataYoutubeService,
                                 GAsyncResult,
                                 gpointer
                               ),
  gpointer                     $user_data
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_service_query_videos (
  GDataYouTubeService        $self,
  GDataQuery                 $query,
  GCancellable               $cancellable,
                             &destroy_progress_user_data (gpointer),
  gpointer                   $progress_user_data,
  CArray[Pointer[GError]]    $error
)
  returns GDataFeed
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_service_query_videos_async (
  GDataYouTubeService $self,
  GDataQuery          $query,
  GCancellable        $cancellable,
                      &progress_callback(
                        GDataEntry,
                        guint
                        guint,
                        gpointer
                      ), #= GDataQueryProgressCallback
  gpointer            $progress_user_data,
                      &destroy_progress_user_data (gpointer),
                      &callback (
                        GDataYoutubeService,
                        GAsyncResult,
                        gpointer
                      ),
  gpointer            $user_data
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_service_upload_video (
  GDataYouTubeService     $self,
  GDataYouTubeVideo       $video,
  Str                     $slug,
  Str                     $content_type,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDataUploadStream
  is      native(gdata)
  is      export
{ * }
