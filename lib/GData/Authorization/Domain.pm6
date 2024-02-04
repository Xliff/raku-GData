use v6.c;

use Method::Also;

use NativeCall;

use GData::Raw::Types;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GDataAuthorizationDomainAncestry is export of Mu
  where GDataAuthorizationDomain | GObject;

class GData::Authorization::Domain {
  also does GLib::Roles::Object;

  has GDataAuthorizationDomain $!gad is implementor;

  submethod BUILD ( :$gdata-auth-domain ) {
    self.setGDataAuthorizationDomain($gdata-auth-domain)
      if $gdata-auth-domain
  }

  method setGDataAuthorizationDomain (GDataAuthorizationDomainAncestry $_) {
    my $to-parent;

    $!gad = do {
      when GDataAuthorizationDomain {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataAuthorizationDomain, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GData::Raw::Definitions::GDataAuthorizationDomain
    is also<GDataAuthorizationDomain>
  { $!gad }

  multi method new (
     $gdata-auth-domain where * ~~ GDataAuthorizationDomainAncestry,
    :$ref                                                            = True
  ) {
    return unless $gdata-auth-domain;

    my $o = self.bless( :$gdata-auth-domain );
    $o.ref if $ref;
    $o;
  }
  multi method new (*%a) {
    my $gdata-auth-domain = self.new-object-ptr(self.get_type);

    my $o = $gdata-auth-domain ?? self.bless( :$gdata-auth-domain ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  method scope is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scope', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('scope', $gv);
      }
    );
  }

  # Type: string
  method service-name
    is rw
    is g-property
    is also<service_name>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('service-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('service-name', $gv);
      }
    );
  }

  method get_scope is also<get-scope> {
    gdata_authorization_domain_get_scope($!gad);
  }

  method get_service_name is also<get-service-name> {
    gdata_authorization_domain_get_service_name($!gad);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gdata_authorization_domain_get_type,
      $n,
      $t
    );
  }
}


### /usr/src/libgdata/gdata/gdata-authorization-domain.h

sub gdata_authorization_domain_get_scope (GDataAuthorizationDomain $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_authorization_domain_get_service_name (
  GDataAuthorizationDomain $self
)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_authorization_domain_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }
