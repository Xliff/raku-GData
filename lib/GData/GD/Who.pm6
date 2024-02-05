use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::GD::Who;

use GData::Parsable;

use GLib::Roles::Implementor;

our subset GDataGDWhoAncestry is export of Mu
  where GDataGDWho | GDataParsableAncestry;

class GData::GD::Who is GData::Parsable {
  has GDataGDWho $!gdw is implementor;

  submethod BUILD ( :$gdata-gd-who ) {
    self.setGDataGDWho($gdata-gd-who)
      if $gdata-gd-who
  }

  method setGDataGDWho (GDataGDWhoAncestry $_) {
    my $to-parent;

    $!gdw = do {
      when GDataGDWho {
        $to-parent = cast(GDataParsable, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataGDWho, $_);
      }
    }
    self.setGDataParsable($to-parent);
  }

  method GData::Raw::Definitions::GDataGDWho
    is also<GDataGDWho>
  { $!gdw }

  multi method new (
     $gdata-gd-who where * ~~ GDataGDWhoAncestry,
    :$ref                                         = True
  ) {
    return unless $gdata-gd-who;

    my $o = self.bless( :$gdata-gd-who );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    Str() $relation_type,
    Str() $value_string,
    Str() $email_address
  ) {
    my $gdata-gd-who = gdata_gd_who_new(
      $relation_type,
      $value_string,
      $email_address
    );

    $gdata-gd-who ?? self.bless( :$gdata-gd-who ) !! Nil;
  }

  # Type: string
  method email-address is rw  is g-property is also<email_address> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('email-address', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('email-address', $gv);
      }
    );
  }

  # Type: string
  method relation-type is rw  is g-property is also<relation_type> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('relation-type', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('relation-type', $gv);
      }
    );
  }

  # Type: string
  method value-string is rw  is g-property is also<value_string> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('value-string', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('value-string', $gv);
      }
    );
  }

  method get_email_address is also<get-email-address> {
    gdata_gd_who_get_email_address($!gdw);
  }

  method get_relation_type is also<get-relation-type> {
    gdata_gd_who_get_relation_type($!gdw);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_gd_who_get_type, $n, $t );
  }

  method get_value_string is also<get-value-string> {
    gdata_gd_who_get_value_string($!gdw);
  }

  method set_email_address (Str() $email_address) is also<set-email-address> {
    gdata_gd_who_set_email_address($!gdw, $email_address);
  }

  method set_relation_type (Str() $relation_type) is also<set-relation-type> {
    gdata_gd_who_set_relation_type($!gdw, $relation_type);
  }

  method set_value_string (Str() $value_string) is also<set-value-string> {
    gdata_gd_who_set_value_string($!gdw, $value_string);
  }

}
