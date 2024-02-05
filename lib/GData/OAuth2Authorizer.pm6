use v6.c;

use NativeCall;
use Method::Also;

use GData::Raw::Types;
use GData::Raw::OAuth2Authorizer;

use GData::Calendar::Service;
# use GData::Documents::Service;
use GData::Picasa::Service;
use GData::Youtube::Service;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GIO::Roles::ProxyResolver;
use GData::Roles::Authorizer;

our subset GDataOAuth2AuthorizerAncestry is export of Mu
  where GDataOAuth2Authorizer | GDataAuthorizer | GObject;

class GData::OAuth2Authorizer {
  also does GLib::Roles::Object;
  also does GData::Roles::Authorizer;

  has GDataOAuth2Authorizer $!goa is implementor;

  submethod BUILD ( :$gdata-auth-o2 ) {
    self.setGDataOAuth2Authorizer($gdata-auth-o2) if $gdata-auth-o2
  }

  method setGDataOAuth2Authorizer (GDataOAuth2AuthorizerAncestry $_) {
    my $to-parent;

    $!goa = do {
      when GDataOAuth2Authorizer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GDataAuthorizer {
        $!ga = $_;
        $to-parent = cast(GObject, $_);
        cast(GDataOAuth2Authorizer, $_)
      }

      default {
        $to-parent = $_;
        cast(GDataOAuth2Authorizer, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GDataAuthorizer;
  }

  method GData::Raw::Structs::GDataOAuth2Authorizer
    is also<GDataOAuth2Authorizer>
  { $!goa }

  multi method new (
     $gdata-auth-o2 where * ~~ GDataOAuth2AuthorizerAncestry,
    :$ref                                                     = True
  ) {
    return unless $gdata-auth-o2;

    my $o = self.bless( :$gdata-auth-o2 );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    Str() $client_id,
    Str() $client_secret,
    Str() $redirect_uri,
    Int() $service_type
  ) {
    my GType $s = $service_type;

    my $gdata-auth-o2 = gdata_oauth2_authorizer_new(
      $client_id,
      $client_secret,
      $redirect_uri,
      $service_type
    );

    $gdata-auth-o2 ?? self.bless( :$gdata-auth-o2 ) !! Nil
  }

  multi method new_youtube (
    Str() $client_id,
    Str() $client_secret,
    Str() $redirect_uri
  )
    is also<new-youtube>
  {
    self.new(
      $client_id,
      $client_secret,
      $redirect_uri,
      GData::Youtube::Service.get_type
    );
  }

  multi method new_picasa (
    Str() $client_id,
    Str() $client_secret,
    Str() $redirect_uri
  )
    is also<
      new-picasa
      new-photos
      new_photos
    >
  {
    self.new(
      $client_id,
      $client_secret,
      $redirect_uri,
      GData::Picasa::Service.get_type
    );
  }

  multi method new_calendar (
    Str() $client_id,
    Str() $client_secret,
    Str() $redirect_uri,
  )
    is also<
      new-calendar
      new_cal
      new-cal
    >
  {
    self.new(
      $client_id,
      $client_secret,
      $redirect_uri,
      GData::Calendar::Service.get_type
    );
  }

  multi method new_docs (
    Str() $client_id,
    Str() $client_secret,
    Str() $redirect_uri,
  )
    is also<new-docs>
  {
    self.new(
      $client_id,
      $client_secret,
      $redirect_uri,
      GData::Documents::Service.get_type
    );
  }

  proto method new_for_authorization_domains (|)
    is also<new-for-authorization-domains>
  { * }

  multi method new_for_authorization_domains (
    $client_id,
    $client_secret,
    $redirect_uri,
    $_
  ) {
    when .^can('Array') { samewith( .Array ) }
    when GLib::GList    { samewith( .GList ) }
    when .^can('GList') { samewith( .GList ) }

    default {
      X::GLib::InvalidType.new(
        message => "Cannot use a { .^name } in a call to {
                    '' }.new_for_authorization_domains!"
      ).throw;
    }
  }
  multi method new_for_authorization_domains (
    Str $client_id,
    Str $client_secret,
    Str $redirect_uri,
        @domains
  ) {
    samewith(
      $client_id,
      $client_secret,
      $redirect_uri,
      GLib::GList.new(@domains, typed => GDataAuthorizationDomain)
    );
  }
  multi method new_for_authorization_domains (
    Str() $client_id,
    Str() $client_secret,
    Str() $redirect_uri,
    GList $authorization_domains
  ) {
    my $gdata-auth-o2 = gdata_oauth2_authorizer_new_for_authorization_domains(
      $client_id,
      $client_secret,
      $redirect_uri,
      $authorization_domains
    );

    $gdata-auth-o2 ?? self.bless( :$gdata-auth-o2 ) !! Nil
  }

  # Type: string
  method client-id is rw  is g-property is also<client_id> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('client-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('client-id', $gv);
      }
    );
  }

  # Type: string
  method client-secret is rw  is g-property is also<client_secret> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('client-secret', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('client-secret', $gv);
      }
    );
  }

  # Type: string
  method locale is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('locale', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('locale', $gv);
      }
    );
  }

  # Type: GProxyResolver
  method proxy-resolver ( :$raw = False )
    is rw
    is g-property
    is also<proxy_resolver>
  {
    my $gv = GLib::Value.new( GIO::ProxyResolver.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('proxy-resolver', $gv);
        propReturnObject($gv.object, $raw, |GIO::ProxyResolver.getTypePair)
      },
      STORE => -> $, GProxyResolver() $val is copy {
        $gv.object = $val;
        self.prop_set('proxy-resolver', $gv);
      }
    );
  }

  # Type: string
  method redirect-uri is rw  is g-property is also<redirect_uri> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('redirect-uri', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('redirect-uri', $gv);
      }
    );
  }

  # Type: string
  method refresh-token is rw  is g-property is also<refresh_token> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('refresh-token', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('refresh-token', $gv);
      }
    );
  }

  # Type: uint
  method timeout is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('timeout', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('timeout', $gv);
      }
    );
  }

  proto method build_authentication_uri (|)
  { * }

  # cw: Why isn't this firing?
  multi method build_authentication_uri ( :scopes(:$all) is required ) {
    say '»»»»»»»»»»»»»»»»»»»»»»»»» Here...';
    samewith(Str, True);
  }
  multi method build_authentication_uri (
    Str() $login_hint,
    Int() $include_granted_scopes = False
  )
    is also<build-authentication-uri>
  {
    my gboolean $i = $include_granted_scopes.so.Int;

    gdata_oauth2_authorizer_build_authentication_uri($!goa, $login_hint, $i);
  }

  method dup_refresh_token is also<dup-refresh-token> {
    gdata_oauth2_authorizer_dup_refresh_token($!goa);
  }

  method get_client_id is also<get-client-id> {
    gdata_oauth2_authorizer_get_client_id($!goa);
  }

  method get_client_secret is also<get-client-secret> {
    gdata_oauth2_authorizer_get_client_secret($!goa);
  }

  method get_locale is also<get-locale> {
    gdata_oauth2_authorizer_get_locale($!goa);
  }

  method get_proxy_resolver ( :$raw = False ) is also<get-proxy-resolver> {
    propReturnObject(
      gdata_oauth2_authorizer_get_proxy_resolver($!goa),
      $raw,
      |GIO::ProxyResolver.getTypePair
    );
  }

  method get_redirect_uri is also<get-redirect-uri> {
    gdata_oauth2_authorizer_get_redirect_uri($!goa);
  }

  method get_timeout is also<get-timeout> {
    gdata_oauth2_authorizer_get_timeout($!goa);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_oauth2_authorizer_get_type, $n, $t );
  }

  method request_authorization (
    Str()                   $authorization_code,
    GCancellable()          $cancellable         = GCancellable,
    CArray[Pointer[GError]] $error               = gerror
  )
    is also<request-authorization>
  {
    clear_error;
    my $rv = so gdata_oauth2_authorizer_request_authorization(
      $!goa,
      $authorization_code,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method request_authorization_async (|)
    is also<request-authorization-async>
  { * }

  multi method request_authorization_async (
     $authorization_code,
     &callback,
     $user_data           = gpointer,
    :$cancellable         = GCancellable
  ) {
    samewith(
      $authorization_code,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method request_authorization_async (
    Str()          $authorization_code,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data            = gpointer
  ) {
    gdata_oauth2_authorizer_request_authorization_async(
      $!goa,
      $authorization_code,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method request_authorization_finish (
    GAsyncResult()          $async_result,
    CArray[Pointer[GError]] $error         = gerror
  )
    is also<request-authorization-finish>
  {
    clear_error;
    my $rv = so gdata_oauth2_authorizer_request_authorization_finish(
      $!goa,
      $async_result,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_locale (Str() $locale) is also<set-locale> {
    gdata_oauth2_authorizer_set_locale($!goa, $locale);
  }

  method set_proxy_resolver (GProxyResolver() $proxy_resolver)
    is also<set-proxy-resolver>
  {
    gdata_oauth2_authorizer_set_proxy_resolver($!goa, $proxy_resolver);
  }

  method set_refresh_token (Str() $refresh_token) is also<set-refresh-token> {
    gdata_oauth2_authorizer_set_refresh_token($!goa, $refresh_token);
  }

  method set_timeout (Int() $timeout) is also<set-timeout> {
    my guint $t = $timeout;

    gdata_oauth2_authorizer_set_timeout($!goa, $t);
  }

}
