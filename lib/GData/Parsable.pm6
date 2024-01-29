use v6.c;

use Method::Also;

use GData::Raw::Types;
use GData::Raw::Parsable;

use GLib::Raw::Implementor;
use GLib::Raw::Object;


our subset GDataParsableAncestry is export of Mu
  where GDataParsable | GObject;

class GData::Parsable {
  also does GLib::Raw::Object;

  has GDataParsable $!gp is implementor;

  submethod BUILD ( :$gdata-parsable ) {
    self.setGDataParsable($gdata-parsable) if $gdata-parsable
  }

  method setGDataParsable (GDataParsableAncestry $_) {
    my $to-parent;

    $!gp = do {
      when GDataParsable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataParsable, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GData::Raw::Definitions::GDataParsable
    is also<GDataParsable>
  { $!gp }

  multi method new (
     $gdata-parsable where * ~~ GDataParsableAncestry,
    :$ref                                               = True
  ) {
    return unless $gdata-parsable;

    my $o = self.bless( :$gdata-parsable );
    $o.ref if $ref;
    $o;
  }

  proto method new_from_json (|)
    is also<new-from-json>
  { * }

  multi method new_from_json ($json, $error = gerror) {
    my $b = resolveBuffer($xml);

    samewith($b, $b.elems, $error);
  }
  multi method new_from_json (
    CArray[uint8]           $json,
    Int()                   $length,
    CArray[Pointer[GError]] $error
  ) {
    my gint $l = length;

    Int()gdata_parsable_new_from_json($!gp, $json, $l, $error);
  }

  proto method new_from_xml (|)
    is also<new-from-xml>
  { * }

  method new_from_xml ($xml, $error = gerror) {
    my $b = resolveBuffer($xml);

    samewith($b, $b.elems, $error);
  }
  method new_from_xml (
    CArray[uint8]           $xml,
    Int()                   $length,
    CArray[Pointer[GError]] $error
  ) {
    my gint $l = length;
    gdata_parsable_new_from_xml($!gp, $xml, $l, $error);
  }

  # Type: boolean
  method constructed-from-xml
    is rw
    is g-property
    is also<constructed_from_xml>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('constructed-from-xml', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('constructed-from-xml', $gv);
      }
    );
  }

  method get_content_type is also<get-content-type> {
    gdata_parsable_get_content_type($!gp);
  }

  method get_json is also<get-json> {
    gdata_parsable_get_json($!gp);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_parsable_get_type, $n, $t );
  }

  method get_xml is also<get-xml> {
    gdata_parsable_get_xml($!gp);
  }

}
