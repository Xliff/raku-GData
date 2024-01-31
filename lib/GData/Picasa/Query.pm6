use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::Picasa::Query;

use GData::Query;

use GLib::Roles::Implementor;

our subset GDataPicasaWebQueryAncestry is export of Mu
  where GDataPicasaWebQuery | GDataQueryAncestry;

class GData::Picasa::Query is GData::Query {
  has GDataPicasaWebQuery $!gpq is implementor;

  submethod BUILD ( :$gdata-pic-q ) {
    self.setGDataPicasaWebQuery($gdata-pic-q) if $gdata-pic-q
  }

  method setGDataPicasaWebQuery (GDataPicasaWebQueryAncestry $_) {
    my $to-parent;

    $!gpq = do {
      when GDataPicasaWebQuery {
        $to-parent = cast(GDataQuery, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataPicasaWebQuery, $_);
      }
    }
    self.setGDataQuery($to-parent);
  }

  method GData::Raw::Definitions::GDataPicasaWebQuery
    is also<GDataPicasaWebQuery>
  { $!gpq }

  multi method new (
     $gdata-pic-q where * ~~ GDataPicasaWebQueryAncestry,
    :$ref                                                 = True
  ) {
    return unless $gdata-pic-q;

    my $o = self.bless( :$gdata-pic-q );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $q = Str) {
    my $gdata-pic-q = gdata_picasaweb_query_new($q);

    $gdata-pic-q ?? self.bless( :$gdata-pic-q ) !! Nil
  }

  method new_with_limits (
    Str() $q,
    Int() $start_index,
    Int() $max_results
  )
    is also<new-with-limits>
  {
    my guint ($s, $m);

    my $gdata-pic-q = gdata_picasaweb_query_new_with_limits($q, $s, $m);

    $gdata-pic-q ?? self.bless( :$gdata-pic-q ) !! Nil
  }

  # Type: string
  method image-size is rw  is g-property is also<image_size> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('image-size', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('image-size', $gv);
      }
    );
  }

  # Type: string
  method location is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('location', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('location', $gv);
      }
    );
  }

  # Type: string
  method tag is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tag', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('tag', $gv);
      }
    );
  }

  # Type: string
  method thumbnail-size is rw  is g-property is also<thumbnail_size> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('thumbnail-size', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('thumbnail-size', $gv);
      }
    );
  }

  # Type: int
  method visibility ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visibility', $gv);
        my $v = $gv.int;
        return $v unless $enum;
        GDataPicasaWebVisibilityEnum($v);
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('visibility', $gv);
      }
    );
  }

  proto method get_bounding_box (|)
    is also<get-bounding-box>
  { * }

  multi method get_bounding_box {
    samewith($, $, $, $);
  }
  multi method get_bounding_box (
    $north is rw,
    $east  is rw,
    $south is rw,
    $west  is rw
  ) {
    my gdouble ($n, $e, $w, $s) = 0e0 xx 4;

    gdata_picasaweb_query_get_bounding_box($!gpq, $n, $e, $s, $w);
    ($north, $east, $south, $west) = ($n, $e, $s, $w);
  }

  method get_image_size is also<get-image-size> {
    gdata_picasaweb_query_get_image_size($!gpq);
  }

  method get_location is also<get-location> {
    gdata_picasaweb_query_get_location($!gpq);
  }

  method get_tag is also<get-tag> {
    gdata_picasaweb_query_get_tag($!gpq);
  }

  method get_thumbnail_size is also<get-thumbnail-size> {
    gdata_picasaweb_query_get_thumbnail_size($!gpq);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_picasaweb_query_get_type, $n, $t );
  }

  method get_visibility ( :$enum = True ) is also<get-visibility> {
    my $v = gdata_picasaweb_query_get_visibility($!gpq);
    return $v unless $enum;
    GDataPicasaWebVisibilityEnum($v);
  }

  method set_bounding_box (
    Num() $north,
    Num() $east,
    Num() $south,
    Num() $west
  )
    is also<set-bounding-box>
  {
    my gdouble ($n, $e, $w, $s) = ($north, $east, $west, $south);

    gdata_picasaweb_query_set_bounding_box($!gpq, $n, $e, $s, $w);
  }

  method set_image_size (Str() $image_size) is also<set-image-size> {
    gdata_picasaweb_query_set_image_size($!gpq, $image_size);
  }

  method set_location (Str() $location) is also<set-location> {
    gdata_picasaweb_query_set_location($!gpq, $location);
  }

  method set_tag (Str() $tag) is also<set-tag> {
    gdata_picasaweb_query_set_tag($!gpq, $tag);
  }

  method set_thumbnail_size (Str() $thumbnail_size)
    is also<set-thumbnail-size>
  {
    gdata_picasaweb_query_set_thumbnail_size($!gpq, $thumbnail_size);
  }

  method set_visibility (Int() $visibility) is also<set-visibility> {
    my GDataPicasaWebVisibility $v = $visibility;

    gdata_picasaweb_query_set_visibility($!gpq, $v);
  }

}
