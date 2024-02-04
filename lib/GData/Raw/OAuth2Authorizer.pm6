use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::OAuth2Authorizer;

### /usr/src/libgdata/gdata/gdata-oauth2-authorizer.h

sub gdata_oauth2_authorizer_build_authentication_uri (
  GDataOAuth2Authorizer $self,
  Str                   $login_hint,
  gboolean              $include_granted_scopes
)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_dup_refresh_token (GDataOAuth2Authorizer $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_get_client_id (GDataOAuth2Authorizer $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_get_client_secret (GDataOAuth2Authorizer $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_get_locale (GDataOAuth2Authorizer $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_get_proxy_resolver (GDataOAuth2Authorizer $self)
  returns GProxyResolver
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_get_redirect_uri (GDataOAuth2Authorizer $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_get_timeout (GDataOAuth2Authorizer $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_new (
  Str   $client_id,
  Str   $client_secret,
  Str   $redirect_uri,
  GType $service_type
)
  returns GDataOAuth2Authorizer
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_new_for_authorization_domains (
  Str   $client_id,
  Str   $client_secret,
  Str   $redirect_uri,
  GList $authorization_domains
)
  returns GDataOAuth2Authorizer
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_request_authorization (
  GDataOAuth2Authorizer   $self,
  Str                     $authorization_code,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_request_authorization_async (
  GDataOAuth2Authorizer $self,
  Str                   $authorization_code,
  GCancellable          $cancellable,
                        &callback (
                          GDataOAuth2Authorizer,
                          GAsyncResult,
                          gpointer
                        ), #= GAsyncReadyCallback(GDataOAuth2Authorizer)
  gpointer              $user_data
)
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_request_authorization_finish (
  GDataOAuth2Authorizer   $self,
  GAsyncResult            $async_result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_set_locale (
  GDataOAuth2Authorizer $self,
  Str                   $locale
)
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_set_proxy_resolver (
  GDataOAuth2Authorizer $self,
  GProxyResolver        $proxy_resolver
)
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_set_refresh_token (
  GDataOAuth2Authorizer $self,
  Str                   $refresh_token
)
  is      native(gdata)
  is      export
{ * }

sub gdata_oauth2_authorizer_set_timeout (
  GDataOAuth2Authorizer $self,
  guint                 $timeout
)
  is      native(gdata)
  is      export
{ * }
