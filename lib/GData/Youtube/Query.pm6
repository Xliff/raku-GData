use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::Youtube::Query;

use GData::Enums;
use GData::Query;

use GLib::Roles::Implementor;

our subset GDataYouTubeQueryAncestry is export of Mu
  where GDataYouTubeQuery | GDataQueryAncestry;

class GData::Youtube::Query is GData::Query {
  has GDataYouTubeQuery $!gyq is implementor;

  submethod BUILD ( :$gdata-youquery ) {
    self.setGDataYouTubeQuery($gdata-youquery) if $gdata-youquery
  }

  method setGDataYouTubeQuery (GDataYouTubeQueryAncestry $_) {
    my $to-parent;

    $!gyq = do {
      when GDataYouTubeQuery {
        $to-parent = cast(GDataQuery, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataYouTubeQuery, $_);
      }
    }
    self.setGDataQuery($to-parent);
  }

  method GData::Raw::Structs::GDataYouTubeQuery
    is also<GDataYouTubeQuery>
  { $!gyq }

  multi method new (
     $gdata-youquery where * ~~ GDataYouTubeQueryAncestry,
    :$ref                                                  = True
  ) {
    return unless $gdata-youquery;

    my $o = self.bless( :$gdata-youquery );
    $o.ref if $ref;
    $o;
  }

  multi method new (Str() $q = Str) {
    my $gdata-youquery = gdata_youtube_query_new($q);

    $gdata-youquery ?? self.bless( :$gdata-youquery ) !! Nil;
  }

  # Type: GDataYoutubeAge
  method age ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GData::Enums::Youtube::Age.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('age', $gv);
        my $a = $gv.enum;
        return $a unless $enum;
        GDataYouTubeAgeEnum($a);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GDataYouTubeAge) = $val;
        self.prop_set('age', $gv);
      }
    );
  }

  # Type: string
  method channel-id is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('channel-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('channel-id', $gv);
      }
    );
  }

  # Type: double
  method latitude is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('latitude', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('latitude', $gv);
      }
    );
  }

  # Type: string
  method license is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('license', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('license', $gv);
      }
    );
  }

  # Type: double
  method location-radius is rw  is g-property is also<location_radius> {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('location-radius', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('location-radius', $gv);
      }
    );
  }

  # Type: double
  method longitude is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('longitude', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('longitude', $gv);
      }
    );
  }

  # Type: string
  method order-by is rw  is g-property is also<order_by> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('order-by', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('order-by', $gv);
      }
    );
  }

  # Type: string
  method restriction is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('restriction', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('restriction', $gv);
      }
    );
  }

  # Type: GDataYoutubeSafeSearch
  method safe-search ( :$enum = True )
    is rw
    is g-property
    is also<safe_search>
  {
    my $gv = GLib::Value.new( GData::Enums::Youtube::SafeSearch.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('safe-search', $gv);
        my $s = $gv.enum;
        return $s unless $enum;
        GDataYouTubeSafeSearchEnum($s);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GDataYouTubeSafeSearch) = $val;
        self.prop_set('safe-search', $gv);
      }
    );
  }

  method get_age ( :$enum = True ) is also<get-age> {
    my $a = gdata_youtube_query_get_age($!gyq);
    return $a unless $enum;
    GDataYouTubeAgeEnum($a);
  }

  method get_channel_id is also<get-channel_id> {
    gdata_youtube_query_get_license($!gyq);
  }

  method get_license is also<get-license> {
    gdata_youtube_query_get_license($!gyq);
  }

  proto method get_location (|)
    is also<get-location>
  { * }

  multi method get_location {
    samewith($, $, $);
  }
  multi method get_location (
    $latitude  is rw,
    $longitude is rw,
    $radius    is rw
  ) {
    my gdouble ($lat, $lon, $r) = 0e0 xx 3;
    gdata_youtube_query_get_location($!gyq, $lat, $lon, $r);
    ($lat, $lon, $radius) = ($lat, $lon, $r);
  }

  method get_order_by is also<get-order-by> {
    gdata_youtube_query_get_order_by($!gyq);
  }

  method get_restriction is also<get-restriction> {
    gdata_youtube_query_get_restriction($!gyq);
  }

  method get_safe_search ( :$enum = True ) is also<get-safe-search> {
    my $s = gdata_youtube_query_get_safe_search($!gyq);
    return $s unless $enum;
    GDataYouTubeSafeSearchEnum($s);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_youtube_query_get_type, $n, $t );
  }

  method set_age (Int() $age) is also<set-age> {
    my GDataYouTubeAge   $a = $age;

    gdata_youtube_query_set_age($!gyq, $a);
  }

  method set_channel_id (Str() $channel-id) is also<set-channel-id> {
    gdata_youtube_query_set_license($!gyq, $channel-id);
  }

  method set_license (Str() $license) is also<set-license> {
    gdata_youtube_query_set_license($!gyq, $license);
  }

  method set_location (Num() $latitude, Num() $longitude, Num() $radius)
    is also<set-location>
  {
    my gdouble ($lat, $lon, $r) = ($lat, $lon, $radius);

    gdata_youtube_query_set_location($!gyq, $lat, $lon, $r);
  }

  method set_order_by (Str() $order_by) is also<set-order-by> {
    gdata_youtube_query_set_order_by($!gyq, $order_by);
  }

  method set_restriction (Str() $restriction) is also<set-restriction> {
    gdata_youtube_query_set_restriction($!gyq, $restriction);
  }

  method set_safe_search (Int() $safe_search) is also<set-safe-search> {
    my GDataYouTubeSafeSearch $s = $safe_search;

    gdata_youtube_query_set_safe_search($!gyq, $s);
  }

}
