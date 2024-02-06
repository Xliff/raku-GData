use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::GD::Where;

use GData::Parsable;

use GLib::Roles::Implementor;

our subset GDataGDWhereAncestry is export of Mu
  where GDataGDWhere | GDataParsableAncestry;

class GData::GD::Where is GData::Parsable {
  has GDataGDWhere $!gdw is implementor;

  submethod BUILD ( :$gdata-gd-where ) {
    self.setGDataGDWhere($gdata-gd-where) if $gdata-gd-where
  }

  method setGDataGDWhere (GDataGDWhereAncestry $_) {
    my $to-parent;

    $!gdw = do {
      when GDataGDWhere {
        $to-parent = cast(GDataParsable, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataGDWhere, $_);
      }
    }
    self.setGDataParsable($to-parent);
  }

  method GData::Raw::Structs::GDataGDWhere
    is also<GDataGDWhere>
  { $!gdw }

  multi method new (
     $gdata-gd-where where * ~~ GDataGDWhereAncestry,
    :$ref                                             = True
  ) {
    return unless $gdata-gd-where;

    my $o = self.bless( :$gdata-gd-where );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str() $relation_type;
    Str() $value_string,
    Str() $label
  ) {
    my $gdata-gd-where = gdata_gd_where_new(
      $relation_type,
      $value_string,
      $label
    );

    $gdata-gd-where ?? self.bless( :$gdata-gd-where ) !! Nil;
  }

  # Type: string
  method label is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('label', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('label', $gv);
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

  method get_label is also<get-label> {
    gdata_gd_where_get_label($!gdw);
  }

  method get_relation_type is also<get-relation-type> {
    gdata_gd_where_get_relation_type($!gdw);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_gd_where_get_type, $n, $t );
  }

  method get_value_string is also<get-value-string> {
    gdata_gd_where_get_value_string($!gdw);
  }

  method set_label (Str() $label) is also<set-label> {
    gdata_gd_where_set_label($!gdw, $label);
  }

  method set_relation_type (Str() $relation_type) is also<set-relation-type> {
    gdata_gd_where_set_relation_type($!gdw, $relation_type);
  }

  method set_value_string (Str() $value_string) is also<set-value-string> {
    gdata_gd_where_set_value_string($!gdw, $value_string);
  }

}
