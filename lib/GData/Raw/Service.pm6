use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::Service;

### /usr/src/libgdata/gdata/gdata-service.h

sub gdata_service_delete_entry (
  GDataService             $self,
  GDataAuthorizationDomain $domain,
  GDataEntry               $entry,
  GCancellable             $cancellable,
  CArray[Pointer[GError]]  $error
)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_service_delete_entry_async (
  GDataService             $self,
  GDataAuthorizationDomain $domain,
  GDataEntry               $entry,
  GCancellable             $cancellable,
  GAsyncReadyCallback      $callback,
  gpointer                 $user_data
)
  is      native(gdata)
  is      export
{ * }

sub gdata_service_delete_entry_finish (
  GDataService            $self,
  GAsyncResult            $async_result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_service_error_quark
  returns GQuark
  is      native(gdata)
  is      export
{ * }

sub gdata_service_get_authorization_domains (GType $service_type)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_service_get_authorizer (GDataService $self)
  returns GDataAuthorizer
  is      native(gdata)
  is      export
{ * }

sub gdata_service_get_locale (GDataService $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_service_get_proxy_resolver (GDataService $self)
  returns GProxyResolver
  is      native(gdata)
  is      export
{ * }

sub gdata_service_get_timeout (GDataService $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_service_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_service_insert_entry (
  GDataService             $self,
  GDataAuthorizationDomain $domain,
  Str                      $upload_uri,
  GDataEntry               $entry,
  GCancellable             $cancellable,
  CArray[Pointer[GError]]  $error
)
  returns GDataEntry
  is      native(gdata)
  is      export
{ * }

sub gdata_service_insert_entry_async (
  GDataService             $self,
  GDataAuthorizationDomain $domain,
  Str                      $upload_uri,
  GDataEntry               $entry,
  GCancellable             $cancellable,
  GAsyncReadyCallback      $callback,
  gpointer                 $user_data
)
  is      native(gdata)
  is      export
{ * }

sub gdata_service_insert_entry_finish (
  GDataService            $self,
  GAsyncResult            $async_result,
  CArray[Pointer[GError]] $error
)
  returns GDataEntry
  is      native(gdata)
  is      export
{ * }

sub gdata_service_is_authorized (GDataService $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_service_query (
  GDataService               $self,
  GDataAuthorizationDomain   $domain,
  Str                        $feed_uri,
  GDataQuery                 $query,
  GType                      $entry_type,
  GCancellable               $cancellable,
  gpointer                   $progress_callback, #= GDataQueryProgressCallback
  gpointer                   $progress_user_data,
  CArray[Pointer[GError]]    $error
)
  returns GDataFeed
  is      native(gdata)
  is      export
{ * }

sub gdata_service_query_async (
  GDataService               $self,
  GDataAuthorizationDomain   $domain,
  Str                        $feed_uri,
  GDataQuery                 $query,
  GType                      $entry_type,
  GCancellable               $cancellable,
  gpointer                   $progress_callback, #= GDataQueryProgressCallback
  gpointer                   $progress_user_data,
  GDestroyNotify             $destroy_progress_user_data,
  GAsyncReadyCallback        $callback,
  gpointer                   $user_data
)
  is      native(gdata)
  is      export
{ * }

sub gdata_service_query_finish (
  GDataService            $self,
  GAsyncResult            $async_result,
  CArray[Pointer[GError]] $error
)
  returns GDataFeed
  is      native(gdata)
  is      export
{ * }

sub gdata_service_query_single_entry (
  GDataService             $self,
  GDataAuthorizationDomain $domain,
  Str                      $entry_id,
  GDataQuery               $query,
  GType                    $entry_type,
  GCancellable             $cancellable,
  CArray[Pointer[GError]]  $error
)
  returns GDataEntry
  is      native(gdata)
  is      export
{ * }

sub gdata_service_query_single_entry_async (
  GDataService             $self,
  GDataAuthorizationDomain $domain,
  Str                      $entry_id,
  GDataQuery               $query,
  GType                    $entry_type,
  GCancellable             $cancellable,
                           &callback (GDataService, GAsyncResult, gpointer),
  gpointer                 $user_data
)
  is      native(gdata)
  is      export
{ * }

sub gdata_service_query_single_entry_finish (
  GDataService            $self,
  GAsyncResult            $async_result,
  CArray[Pointer[GError]] $error
)
  returns GDataEntry
  is      native(gdata)
  is      export
{ * }

sub gdata_service_set_authorizer (
  GDataService    $self,
  GDataAuthorizer $authorizer
)
  is      native(gdata)
  is      export
{ * }

sub gdata_service_set_locale (
  GDataService $self,
  Str          $locale
)
  is      native(gdata)
  is      export
{ * }

sub gdata_service_set_proxy_resolver (
  GDataService   $self,
  GProxyResolver $proxy_resolver
)
  is      native(gdata)
  is      export
{ * }

sub gdata_service_set_timeout (
  GDataService $self,
  guint        $timeout
)
  is      native(gdata)
  is      export
{ * }

sub gdata_service_update_entry (
  GDataService             $self,
  GDataAuthorizationDomain $domain,
  GDataEntry               $entry,
  GCancellable             $cancellable,
  CArray[Pointer[GError]]  $error
)
  returns GDataEntry
  is      native(gdata)
  is      export
{ * }

sub gdata_service_update_entry_async (
  GDataService             $self,
  GDataAuthorizationDomain $domain,
  GDataEntry               $entry,
  GCancellable             $cancellable,
                           &callback (GDataService, GAsyncResult, gpointer),
  gpointer                 $user_data
)
  is      native(gdata)
  is      export
{ * }

sub gdata_service_update_entry_finish (
  GDataService            $self,
  GAsyncResult            $async_result,
  CArray[Pointer[GError]] $error
)
  returns GDataEntry
  is      native(gdata)
  is      export
{ * }
