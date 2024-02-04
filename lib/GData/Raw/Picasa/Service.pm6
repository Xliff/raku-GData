use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::Picasa::Service;

### /usr/src/libgdata/gdata/services/picasaweb/gdata-picasaweb-service.h

sub gdata_picasaweb_service_finish_file_upload (
  GDataPicasaWebService   $self,
  GDataUploadStream       $upload_stream,
  CArray[Pointer[GError]] $error
)
  returns GDataPicasaWebFile
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_service_get_primary_authorization_domain
  returns GDataAuthorizationDomain
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_service_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_service_get_user (
  GDataPicasaWebService   $self,
  Str                     $username,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDataPicasaWebUser
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_service_get_user_async (
  GDataPicasaWebService $self,
  Str                   $username,
  GCancellable          $cancellable,
                        &callback (
                          GDataPicasaWebService,
                          GAsyncResult,
                          gpointer
                        ),
  gpointer              $user_data
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_service_get_user_finish (
  GDataPicasaWebService   $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GDataPicasaWebUser
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_service_insert_album (
  GDataPicasaWebService   $self,
  GDataPicasaWebAlbum     $album,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDataPicasaWebAlbum
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_service_insert_album_async (
  GDataPicasaWebService $self,
  GDataPicasaWebAlbum   $album,
  GCancellable          $cancellable,
                        &callback (
                         GDataPicasaWebService,
                         GAsyncResult,
                         gpointer
                        ),
  gpointer              $user_data
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_service_new (GDataAuthorizer $authorizer)
  returns GDataPicasaWebService
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_service_query_all_albums (
  GDataPicasaWebService      $self,
  GDataQuery                 $query,
  Str                        $username,
  GCancellable               $cancellable,
                             &progress_callback (
                               GDataEntry,
                               guint,
                               guint,
                               gpointer
                             ), #= GDataQueryProgressCallback
  gpointer                   $progress_user_data,
  CArray[Pointer[GError]]    $error
)
  returns GDataPicasaWebFeed
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_service_query_all_albums_async (
  GDataPicasaWebService $self,
  GDataQuery            $query,
  Str                   $username,
  GCancellable          $cancellable,
                        &progress_callback (
                          GDataEntry,
                          guint,
                          guint,
                          gpointer
                        ), #= GDataQueryProgressCallback
  gpointer              $progress_user_data,
                        &destroy_progress_user_data (gpointer),
                        &callback (
                          GDataPicasaWebService,
                          GAsyncResult,
                          gpointer
                        ),
  gpointer              $user_data
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_service_query_files (
  GDataPicasaWebService      $self,
  GDataPicasaWebAlbum        $album,
  GDataQuery                 $query,
  GCancellable               $cancellable,
                             &progress_callback (
                               GDataEntry,
                               guint,
                               guint,
                               gpointer
                             ), #= GDataQueryProgressCallback
  gpointer                   $progress_user_data,
  CArray[Pointer[GError]]    $error
)
  returns GDataPicasaWebFeed
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_service_query_files_async (
  GDataPicasaWebService      $self,
  GDataPicasaWebAlbum        $album,
  GDataQuery                 $query,
  GCancellable               $cancellable,
                             &progress_callback (
                               GDataEntry,
                               guint,
                               guint,
                               gpointer
                             ), #= GDataQueryProgressCallback
  gpointer                   $progress_user_data,
                             &destroy_progress_user_data (gpointer),
                             &callback (
                               GDataPicasaWebService,
                               GAsyncResult,
                               gpointer
                             ),
  gpointer                   $user_data
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_service_upload_file (
  GDataPicasaWebService   $self,
  GDataPicasaWebAlbum     $album,
  GDataPicasaWebFile      $file_entry,
  Str                     $slug,
  Str                     $content_type,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDataUploadStream
  is      native(gdata)
  is      export
{ * }
