use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::Link;

use GData::Parsable;

use GLib::Roles::Implementor;

our subset GDataLinkAncestry is export of Mu
  where GDataLink | GDataParsableAncestry;

class GData::Link is GData::Parsable {
  has GDataLink $!gl is implementor;

  submethod BUILD ( :$gdata-relation ) {
    self.setGDataLink($gdata-relation) if $gdata-relation
  }

  method setGDataLink (GDataLinkAncestry $_) {
    my $to-parent;

    $!gl = do {
      when GDataLink {
        $to-parent = cast(GDataParsable, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataLink, $_);
      }
    }
    self.setGDataParsable($to-parent);
  }

  method GData::Raw::Definitions::GDataLink
    is also<GDataLink>
  { $!gl }

  multi method new ($gdata-relation where * ~~ GDataLinkAncestry , :$ref = True) {
    return unless $gdata-relation;

    my $o = self.bless( :$gdata-relation );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $relation_type) {
    my $gdata-relation = gdata_link_new($!gl, $relation_type);

    $gdata-relation ?? self.bless( :$gdata-relation ) !! Nil;
  }

  # Type: string
  method content-type is rw  is g-property is also<content_type> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('content-type', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('content-type', $gv);
      }
    );
  }

  # Type: string
  method language is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('language', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('language', $gv);
      }
    );
  }

  # Type: int
  method length is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('length', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('length', $gv);
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
  method title is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  # Type: string
  method uri is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('uri', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('uri', $gv);
      }
    );
  }

  method get_content_type is also<get-content-type> {
    gdata_link_get_content_type($!gl);
  }

  method get_language is also<get-language> {
    gdata_link_get_language($!gl);
  }

  method get_length is also<get-length> {
    gdata_link_get_length($!gl);
  }

  method get_relation_type is also<get-relation-type> {
    gdata_link_get_relation_type($!gl);
  }

  method get_title is also<get-title> {
    gdata_link_get_title($!gl);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_link_get_type, $n, $t );
  }

  method get_uri is also<get-uri> {
    gdata_link_get_uri($!gl);
  }

  method set_content_type (Str() $content_type) is also<set-content-type> {
    gdata_link_set_content_type($!gl, $content_type);
  }

  method set_language (Str() $language) is also<set-language> {
    gdata_link_set_language($!gl, $language);
  }

  method set_length (gint() $length) is also<set-length> {
    gdata_link_set_length($!gl, $length);
  }

  method set_relation_type (Str() $relation_type) is also<set-relation-type> {
    gdata_link_set_relation_type($!gl, $relation_type);
  }

  method set_title (Str() $title) is also<set-title> {
    gdata_link_set_title($!gl, $title);
  }

  method set_uri (Str() $uri) is also<set-uri> {
    gdata_link_set_uri($!gl, $uri);
  }

}
