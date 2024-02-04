use v6.c;

use NativeCall;

use GData::Raw::Types;
use SOUP::Raw::Definitions;
use GData::Raw::Authorizer;

role GData::Roles::Authorizer {
  has GDataAuthorizer $!ga is implementor;

  method roleInit-GDataAuthorizer {
    return if $!ga;

    my \i = findProperImplementor(self.^attributes);
    $!ga = cast( GDataAuthorizer, i.get_value(self) );
  }

  method GData::Raw::Structs::GDataAuthorizer { $!ga }
  method GDataAuthorizer                      { $!ga }

  method gdata_authorizer_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_authorizer_get_type, $n, $t );
  }

  method is_authorized_for_domain (GDataAuthorizationDomain() $domain) {
    so gdata_authorizer_is_authorized_for_domain($!ga, $domain);
  }

  method process_request (
    GDataAuthorizationDomain() $domain,
    SoupMessage()              $message
  ) {
    gdata_authorizer_process_request($!ga, $domain, $message);
  }

  method refresh_authorization (
    GCancellable            $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so gdata_authorizer_refresh_authorization(
      $!ga,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method refresh_authorization_async (|)
  { * }

  multi method refresh_authorization_async (
     &callback,
     $user_data   = gpointer,
    :$cancellable = GCancellable
  ) {
    samewith(
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method refresh_authorization_async (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer;
  ) {
    gdata_authorizer_refresh_authorization_async(
      $!ga,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method refresh_authorization_finish (
    GAsyncResult()          $async_result,
    CArray[Pointer[GError]] $error          = gerror
  ) {
    clear_error;
    my $rv = so gdata_authorizer_refresh_authorization_finish(
      $!ga,
      $async_result,
      $error
    );
    set_error($error);
    $rv;
  }

}

use GLib::Roles::Object;
use GLib::Roles::Implementor;

our subset GDataAuthorizerAncestry is export of Mu
  where GDataAuthorizer | GObject;

class GData::Authorizer {
  also does GLib::Roles::Object;
  also does GData::Roles::Authorizer;

  submethod BUILD ( :$gdata-authorizer ) {
    self.setGDataAuthorizer($gdata-authorizer) if $gdata-authorizer;
  }

  method setGDataAuthorizer (GDataAuthorizerAncestry $_) {
    my $to-parent;

    $!ga = do {
      when GDataAuthorizer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataAuthorizer, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GDataAuthorizer;
  }

  multi method new (
     $gdata-authorizer where * ~~ GDataAuthorizerAncestry,
    :$ref                                                  = True
  ) {
    return unless $gdata-authorizer;

    my $o = self.bless( :$gdata-authorizer );
    $o.ref if $ref;
    $o;
  }

}
