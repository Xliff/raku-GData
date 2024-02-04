use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use SOUP::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::Authorizer;

### /usr/src/libgdata/gdata/gdata-authorizer.h

sub gdata_authorizer_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_authorizer_is_authorized_for_domain (
  GDataAuthorizer          $self,
  GDataAuthorizationDomain $domain
)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_authorizer_process_request (
  GDataAuthorizer          $self,
  GDataAuthorizationDomain $domain,
  SoupMessage              $message
)
  is      native(gdata)
  is      export
{ * }

sub gdata_authorizer_refresh_authorization (
  GDataAuthorizer         $self,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_authorizer_refresh_authorization_async (
  GDataAuthorizer     $self,
  GCancellable        $cancellable,
                      &callback (
                        GDataAuthorizer,
                        GAsyncResult,
                        gpointer
                      ), #= GAsyncCallback(GDataAuthorizer)
  gpointer            $user_data
)
  is      native(gdata)
  is      export
{ * }

sub gdata_authorizer_refresh_authorization_finish (
  GDataAuthorizer         $self,
  GAsyncResult            $async_result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdata)
  is      export
{ * }
