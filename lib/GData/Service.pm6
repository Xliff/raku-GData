use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::Service;

use GLib::GList;
use GData::Authorizer;
use GData::Authorization::Domain;
use GData::Entry;
use GData::Feed;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GIO::Roles::ProxyResolver;

our subset GDataServiceAncestry is export of Mu
  where GDataService | GObject;

class GData::Service {
  also does GLib::Roles::Object;

  has GDataService $!gs is implementor;

  submethod BUILD ( :$gdata-service ) {
    self.setGDataService($gdata-service) if $gdata-service
  }

  method setGDataService (GDataServiceAncestry $_) {
    my $to-parent;

    $!gs = do {
      when GDataService {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataService, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GData::Raw::Structs::GDataService
    is also<GDataService>
  { $!gs }

  multi method new (
     $gdata-service where * ~~ GDataServiceAncestry,
    :$ref                                            = True
  ) {
    return unless $gdata-service;

    my $o = self.bless( :$gdata-service );
    $o.ref if $ref;
    $o;
  }

  # Type: GDataAuthorizer
  method authorizer ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GData::Authorizer.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('authorizer', $gv);
        propReturnObject(
          $gv.GDataAuthorizer,
          $raw,
          |GData::Authorizer.getTypePair
        );
      },
      STORE => -> $, GDataAuthorizer() $val is copy {
        $gv.object = $val;
        self.prop_set('authorizer', $gv);
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

  method delete_entry (
    GDataAuthorizationDomain() $domain,
    GDataEntry()               $entry,
    GCancellable()             $cancellable = GCancellable,
    CArray[Pointer[GError]]    $error       = gerror
  )
    is also<delete-entry>
  {
    clear_error;
    my $r = gdata_service_delete_entry(
      $!gs,
      $domain,
      $entry,
      $cancellable,
      $error
    );
    set_error($error);
    $r;
  }

  proto method delete_entry_async (|)
    is also<delete-entry-async>
  { * }

  multi method delete_entry_async (
     $domain,
     $entry,
     &callback,
     $user_data   = gpointer,
    :$cancellable = GCancellable
  ) {
    samewith(
      $domain,
      $entry,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method delete_entry_async (
    GDataAuthorizationDomain $domain,
    GDataEntry               $entry,
    GCancellable             $cancellable,
                             &callback,
    gpointer                 $user_data    = gpointer
  ) {
    gdata_service_delete_entry_async(
      $!gs,
      $domain,
      $entry,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method delete_entry_finish (
    GAsyncResult            $async_result,
    CArray[Pointer[GError]] $error         = gerror
  )
    is also<delete-entry-finish>
  {
    clear_error;
    my $r = gdata_service_delete_entry_finish($!gs, $async_result, $error);
    set_error($error);
    $r;
  }

  method error_quark is static is also<error-quark> {
    gdata_service_error_quark();
  }

  method get_authorization_domains (
    :$raw            = False,
    :gslist(:$glist) = False
  )
    is also<get-authorization-domains>
  {
    returnGList(
      gdata_service_get_authorization_domains($!gs),
      $raw,
      $glist
      |GData::Authorization::Domain.getTypePair
    );
  }

  method get_authorizer ( :$raw = False ) is also<get-authorizer> {
    propReturnObject(
      gdata_service_get_authorizer($!gs),
      $raw,
      |GData::Authorizer.getTypePair
    );
  }

  method get_locale is also<get-locale> {
    gdata_service_get_locale($!gs);
  }

  method get_proxy_resolver ( :$raw = False ) is also<get-proxy-resolver> {
    propReturnObject(
      gdata_service_get_proxy_resolver($!gs),
      $raw,
      |GIO::ProxyResolver.getTypePair
    );
  }

  method get_timeout is also<get-timeout> {
    gdata_service_get_timeout($!gs);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_service_get_type, $n, $t );
  }

  method insert_entry (
    GDataAuthorizationDomain()  $domain,
    Str()                       $upload_uri,
    GDataEntry()                $entry,
    GCancellable()              $cancellable = GCancellable,
    CArray[Pointer[GError]]     $error       = gerror,
                               :$raw         = False
  )
    is also<insert-entry>
  {
    clear_error;
    my $r = gdata_service_insert_entry(
      $!gs,
      $domain,
      $upload_uri,
      $entry,
      $cancellable,
      $error
    );
    set_error($error);
    propReturnObject($r, $raw, |GData::Entry.getTypePair);
  }

  proto method insert_entry_async (|)
    is also<insert-entry-async>
  { * }

  multi method insert_entry_async (
     $domain,
     $upload_uri,
     $entry,
     &callback,
     $user_data    = gpointer,
    :$cancellable  = GCancellable
  ) {
    samewith(
      $domain,
      $upload_uri,
      $entry,
      $cancellable,
      &callback,
      $user_data
    )
  }
  multi method insert_entry_async (
    GDataAuthorizationDomain() $domain,
    Str()                      $upload_uri,
    GDataEntry()               $entry,
    GCancellable()             $cancellable,
                               &callback,
    gpointer                   $user_data    = gerror
  ) {
    gdata_service_insert_entry_async(
      $!gs,
      $domain,
      $upload_uri,
      $entry,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method insert_entry_finish (
    GAsyncResult()           $async_result,
    CArray[Pointer[GError]]  $error         = gerror,
                            :$raw           = False
  )
    is also<insert-entry-finish>
  {
    clear_error;
    my $r = gdata_service_insert_entry_finish($!gs, $async_result, $error);
    set_error($error);
    propReturnObject($r, $raw, |GData::Entry.getTypePair);
  }

  method is_authorized is also<is-authorized> {
    so gdata_service_is_authorized($!gs);
  }

  multi method query (
     $domain,
     $feed_uri,
     $query,
     $entry_type,
     &progress_callback,
     $progress_user_data  = gpointer,
     $error               = gerror,
    :$cancellable         = GCancellable
  ) {
    samewith(
      $domain,
      $feed_uri,
      $query,
      $entry_type,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      $error
    );
  }
  multi method query (
    GDataAuthorizationDomain()  $domain,
    Str()                       $feed_uri,
    GDataQuery()                $query,
    Int()                       $entry_type,
    GCancellable()              $cancellable,
                                &progress_callback,
    gpointer                    $progress_user_data  = gpointer,
    CArray[Pointer[GError]]     $error               = gerror,
                               :$raw                 = False
  ) {
    my GType $e = $entry_type;

    clear_error;
    my $r = gdata_service_query(
      $!gs,
      $domain,
      $feed_uri,
      $query,
      $e,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      $error
    );
    set_error($error);
    propReturnObject($r, $raw, |GData::Feed.getTypePair);
  }

  proto method query_async (|)
    is also<query-async>
  { * }

  multi method query_async (
     $domain,
     $feed_uri,
     $query,
     $entry_type,
     &callback,
     $user_data                    = gpointer,
    :$cancellable                  = GCancellable,
    :&progress_callback            = Callable,
    :$progress_user_data           = gpointer,
    :&destroy_progress_user_data   = %DEFAULT-CALLBACKS<GDestroyNotify>
  ) {
    samewith(
      $domain,
      $feed_uri,
      $query,
      $entry_type,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      &destroy_progress_user_data,
      &callback,
      $user_data
    );
  }
  multi method query_async (
    GDataAuthorizationDomain   $domain,
    Str                        $feed_uri,
    GDataQuery                 $query,
    GType                      $entry_type,
    GCancellable               $cancellable,
                               &progress_callback,
    gpointer                   $progress_user_data,
                               &destroy_progress_user_data,
                               &callback,
    gpointer                   $user_data
  ) {
    my GType $e = $entry_type;

    gdata_service_query_async(
      $!gs,
      $domain,
      $feed_uri,
      $query,
      $entry_type,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      &destroy_progress_user_data,
      &callback,
      $user_data
    );
  }

  method query_finish (
    GAsyncResult()           $async_result,
    CArray[Pointer[GError]]  $error         = gerror,
                            :$raw           = False
  )
    is also<query-finish>
  {
    clear_error;
    my $r = gdata_service_query_finish($!gs, $async_result, $error);
    set_error($error);
    propReturnObject($r, $raw, |GData::Feed.getTypePair)
  }

  method query_single_entry (
    GDataAuthorizationDomain()  $domain,
    Str()                       $entry_id,
    GDataQuery()                $query,
    Int()                       $entry_type,
    GCancellable()              $cancellable = GCancellable,
    CArray[Pointer[GError]]     $error       = gerror,
                               :$raw         = False
  )
    is also<query-single-entry>
  {
    my GType $e = $entry_type;

    clear_error;
    my $r = gdata_service_query_single_entry(
      $!gs,
      $domain,
      $entry_id,
      $query,
      $e,
      $cancellable,
      $error
    );
    set_error($error);
    propReturnObject($r, $raw, |GData::Entry.getTypePair);
  }

  proto method query_single_entry_async (|)
    is also<query-single-entry-async>
  { * }

  multi method query_single_entry_async (
     $domain,
     $entry_id,
     $query,
     $entry_type,
     &callback,
     $user_data    = gpointer,
    :$cancellable  = GCancellable
  ) {
    samewith(
      $domain,
      $entry_id,
      $query,
      $entry_type,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method query_single_entry_async (
    GDataAuthorizationDomain()  $domain,
    Str()                       $entry_id,
    GDataQuery()                $query,
    GType()                     $entry_type,
    GCancellable()              $cancellable,
                                &callback,
    gpointer                    $user_data     = gpointer
  ) {
    my GType $e = $entry_type;

    my $r = gdata_service_query_single_entry_async(
      $!gs,
      $domain,
      $entry_id,
      $query,
      $e,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method query_single_entry_finish (
    GAsyncResult()           $async_result,
    CArray[Pointer[GError]]  $error,
                            :$raw           = False
  )
    is also<query-single-entry-finish>
  {
    propReturnObject(
      gdata_service_query_single_entry_finish($!gs, $async_result, $error),
      $raw,
      |GData::Entry.getTypePair
    );
  }

  method set_authorizer (GDataAuthorizer() $authorizer) is also<set-authorizer> {
    gdata_service_set_authorizer($!gs, $authorizer);
  }

  method set_locale (Str() $locale) is also<set-locale> {
    gdata_service_set_locale($!gs, $locale);
  }

  method set_proxy_resolver (GProxyResolver() $proxy_resolver) is also<set-proxy-resolver> {
    gdata_service_set_proxy_resolver($!gs, $proxy_resolver);
  }

  method set_timeout (Int() $timeout) is also<set-timeout> {
    my guint $t = $timeout;

    gdata_service_set_timeout($!gs, $t);
  }

  method update_entry (
    GDataAuthorizationDomain()  $domain,
    GDataEntry()                $entry,
    GCancellable()              $cancellable = GCancellable,
    CArray[Pointer[GError]]     $error       = gerror,
                               :$raw         = False
  )
    is also<update-entry>
  {
    clear_error
    my $r = gdata_service_update_entry(
      $!gs,
      $domain,
      $entry,
      $cancellable,
      $error
    );
    set_error($error);
    propReturnObject($r, $raw, |GData::Entry.getTypePair);
  }

  proto method update_entry_async (|)
    is also<update-entry-async>
  { * }

  multi method update_entry_async (
     $domain,
     $entry,
     &callback,
     $user_data   = gpointer,
    :$cancellable = GCancellable
  ) {
    samewith(
      $domain,
      $entry,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method update_entry_async (
    GDataAuthorizationDomain() $domain,
    GDataEntry()               $entry,
    GCancellable()             $cancellable,
                               &callback,
    gpointer                   $user_data     = gpointer
  ) {
    gdata_service_update_entry_async(
      $!gs,
      $domain,
      $entry,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method update_entry_finish (
    GAsyncResult()           $async_result,
    CArray[Pointer[GError]]  $error         = gerror,
                            :$raw           = False
  )
    is also<update-entry-finish>
  {
    clear_error;
    my $r = gdata_service_update_entry_finish($!gs, $async_result, $error);
    set_error($error);
    propReturnObject($r, $raw, |GData::Entry.getTypePair);
  }

}
