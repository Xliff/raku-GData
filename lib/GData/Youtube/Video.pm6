use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::Youtube::Video;

use GLib::GList;
use GData::Entry;
# use GData::Media::Category;
# use GData::Youtube::State;

use GLib::Roles::Implementor;

our subset GDataYouTubeVideoAncestry is export of Mu
  where GDataYouTubeVideo | GDataEntryAncestry;

class GData::Youtube::Video is GData::Entry {
  has GDataYouTubeVideo $!gyv is implementor;

  submethod BUILD ( :$gdata-youvid ) {
    self.setGDataYouTubeVideo($gdata-youvid) if $gdata-youvid
  }

  method setGDataYouTubeVideo (GDataYouTubeVideoAncestry $_) {
    my $to-parent;

    $!gyv = do {
      when GDataYouTubeVideo {
        $to-parent = cast(GDataEntry, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataYouTubeVideo, $_);
      }
    }
    self.setGDataEntry($to-parent);
  }

  method GData::Raw::Structs::GDataYouTubeVideo
    is also<GDataYoutubeVideo>
  { $!gyv }

  multi method new (
     $gdata-youvid where * ~~ GDataYouTubeVideoAncestry,
    :$ref                                                = True
  ) {
    return unless $gdata-youvid;

    my $o = self.bless( :$gdata-youvid );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $id) {
    my $gdata-youvid = gdata_youtube_video_new($id);

    $gdata-youvid ?? self.bless( :$gdata-youvid ) !! Nil
  }

  # Type: string
  method aspect-ratio is rw  is g-property is also<aspect_ratio> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('aspect-ratio', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('aspect-ratio', $gv);
      }
    );
  }

  # Type: double
  method average-rating is rw  is g-property is also<average_rating> {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('average-rating', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        warn 'average-rating does not allow writing'
      }
    );
  }

  # Type: GDataMediaCategory
  method category ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GData::Media::Category.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('category', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GData::Media::Category.getTypePair
        );
      },
      STORE => -> $, GDataMediaCategory() $val is copy {
        $gv.object = $val;
        self.prop_set('category', $gv);
      }
    );
  }

  # Type: string
  method description is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('description', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('description', $gv);
      }
    );
  }

  # Type: uint
  method duration is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('duration', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'duration does not allow writing'
      }
    );
  }

  # Type: uint
  method favorite-count is rw  is g-property is also<favorite_count> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('favorite-count', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'favorite-count does not allow writing'
      }
    );
  }

  # Type: boolean
  method is-private is rw  is g-property is also<is_private> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-private', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('is-private', $gv);
      }
    );
  }

  # Type: GStrv
  method keywords ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('keywords', $gv);
        my $ca = cast(CArray[Str], $gv.pointer);
        return $ca if $raw;
        CArrayToArray($ca);
      },
      STORE => -> $, $val is copy {
        $val .= Array if $val.^can('Array');
        $val = ArrayToCArray(Str, $val) if $val ~~ Array;
        X::GLib::InvalidType.new(
          message => "Cannot use a { $val.^name } when setting keywords!"
        ).throw unless $val ~~ CArray[Str];
        $gv.pointer = $val;
        self.prop_set('keywords', $gv);
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

  # Type: uint
  method max-rating is rw  is g-property is also<max_rating> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-rating', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'max-rating does not allow writing'
      }
    );
  }

  # Type: uint
  method min-rating is rw  is g-property is also<min_rating> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('min-rating', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'min-rating does not allow writing'
      }
    );
  }

  # Type: string
  method player-uri is rw  is g-property is also<player_uri> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('player-uri', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'player-uri does not allow writing'
      }
    );
  }

  # Type: uint
  method rating-count is rw  is g-property is also<rating_count> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('rating-count', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'rating-count does not allow writing'
      }
    );
  }

  # Type: int64
  method recorded ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('recorded', $gv);
        my $r = $gv.int64;
        return $r if $raw;
        DateTime.new($r);
      },
      STORE => -> $, $val is copy {
        $val .= DateTime if $val.^can('DateTime');
        $val .= posix    if $val ~~ DateTime;
        $val .= Int      if $val.^can('Int') && $val !~~ Int;
        $gv.int64 = $val;
        self.prop_set('recorded', $gv);
      }
    );
  }

  # Type: GDataYoutubeState
  method state ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GData::Youtube::State.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('state', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GData::Youtube::State.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'state does not allow writing'
      }
    );
  }

  # Type: int64
  method uploaded ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('uploaded', $gv);
        my $u = $gv.int64;
        return $u if $raw;
        DateTime.new($u);
      },
      STORE => -> $, Int() $val is copy {
        warn 'uploaded does not allow writing'
      }
    );
  }

  # Type: uint
  method view-count is rw  is g-property is also<view_count> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('view-count', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'view-count does not allow writing'
      }
    );
  }

  method get_access_control (Str() $action, :$enum = True)
    is also<get-access-control>
  {
    my $p = gdata_youtube_video_get_access_control($!gyv, $action);
    return $p unless $enum;
    GDataYouTubePermissionEnum($p);
  }

  method get_aspect_ratio is also<get-aspect-ratio> {
    gdata_youtube_video_get_aspect_ratio($!gyv);
  }

  method get_category ( :$raw = False ) is also<get-category> {
    propReturnObject(
      gdata_youtube_video_get_category($!gyv),
      $raw,
      |GData::Media::Category.getTypePair
    );
  }

  proto method get_coordinates (|)
    is also<get-coordinates>
  { * }

  multi method get_coordinates {
    samewith($, $);
  }
  multi method get_coordinates ($latitude is rw, $longitude is rw) {
    my gdouble ($lat, $lon) = 0e0 xx 2;

    gdata_youtube_video_get_coordinates($!gyv, $lat, $lon);
    ($latitude, $longitude) = ($lat, $lon);
  }

  method get_description is also<get-description> {
    gdata_youtube_video_get_description($!gyv);
  }

  method get_duration is also<get-duration> {
    gdata_youtube_video_get_duration($!gyv);
  }

  method get_favorite_count is also<get-favorite-count> {
    gdata_youtube_video_get_favorite_count($!gyv);
  }

  method get_keywords ( :$raw = False ) is also<get-keywords> {
    my $ca = gdata_youtube_video_get_keywords($!gyv);
    return $ca if $raw;
    CArrayToArray($ca);
  }

  method get_location is also<get-location> {
    gdata_youtube_video_get_location($!gyv);
  }

  method get_media_rating (Str() $rating_type) is also<get-media-rating> {
    gdata_youtube_video_get_media_rating($!gyv, $rating_type);
  }

  method get_player_uri is also<get-player-uri> {
    gdata_youtube_video_get_player_uri($!gyv);
  }

  method get_url
    is also<
      get-url
      url
    >
  {
    # cw: May be unnecessary, but here for convenience until something
    #     better comes along.
    "https://www.youtube.com/watch?v={ self.id }"
  }


  proto method get_rating (|)
    is also<get-rating>
  { * }

  multi method get_rating {
    samewith($, $, $, $);
  }
  multi method get_rating (
    $min     is rw,
    $max     is rw,
    $count   is rw,
    $average is rw
  ) {
    my gint    ($mn, $mx, $c) = 0 xx 3;
    my gdouble  $a            = 0e0;

    gdata_youtube_video_get_rating($!gyv, $mn, $mx, $c, $a);
    ($min, $max, $count, $average) = ($mn, $mx, $c, $a);
  }

  method get_recorded ( :$raw = False ) is also<get-recorded> {
    my $r = gdata_youtube_video_get_recorded($!gyv);
    return $r if $raw;
    DateTime.new($r);
  }

  method get_state ( :$raw = False ) is also<get-state> {
    propReturnObject(
      gdata_youtube_video_get_state($!gyv),
      $raw,
      |GData::Youtube::State.getTypePair
    );
  }

  method get_thumbnails is also<get-thumbnails> {
    gdata_youtube_video_get_thumbnails($!gyv);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_youtube_video_get_type, $n, $t );
  }

  method get_uploaded ( :$raw = False ) is also<get-uploaded> {
    my $u = gdata_youtube_video_get_uploaded($!gyv);
    return $u if $raw;
    DateTime.new($u);
  }

  method get_video_id_from_uri (Str() $uri)
    is also<get-video-id-from-uri>
    is static
  {
    gdata_youtube_video_get_video_id_from_uri($uri);
  }

  method get_view_count is also<get-view-count> {
    gdata_youtube_video_get_view_count($!gyv);
  }

  method get_is_private is also<get-is-private> {
    so gdata_youtube_video_is_private($!gyv);
  }

  method is_restricted_in_country (Str() $country)
    is also<is-restricted-in-country>
  {
    so gdata_youtube_video_is_restricted_in_country($!gyv, $country);
  }

  method set_access_control (Str() $action, Int() $permission)
    is also<set-access-control>
  {
    my GDataYouTubePermission $p = $permission;

    gdata_youtube_video_set_access_control($!gyv, $action, $permission);
  }

  method set_aspect_ratio (Str() $aspect_ratio) is also<set-aspect-ratio> {
    gdata_youtube_video_set_aspect_ratio($!gyv, $aspect_ratio);
  }

  method set_category (GDataMediaCategory() $category) is also<set-category> {
    gdata_youtube_video_set_category($!gyv, $category);
  }

  method set_coordinates (Num() $latitude, Num() $longitude)
    is also<set-coordinates>
  {
    my gdouble ($lat, $long) = ($latitude, $longitude);

    gdata_youtube_video_set_coordinates($!gyv, $lat, $long);
  }

  method set_description (Str() $description) is also<set-description> {
    gdata_youtube_video_set_description($!gyv, $description);
  }

  method set_is_private (Int() $is_private) is also<set-is-private> {
    my gboolean $i = $is_private.so.Int;

    gdata_youtube_video_set_is_private($!gyv, $i);
  }

  proto method set_keywords (|)
    is also<set-keywords>
  { * }

  multi method set_keywords (@keywords) {
    samewith( ArrayToCArray(Str, @keywords, :null) );
  }
  multi method set_keywords (CArray[Str] $keywords) {
    gdata_youtube_video_set_keywords($!gyv, $keywords);
  }

  method set_location (Str() $location) is also<set-location> {
    gdata_youtube_video_set_location($!gyv, $location);
  }

  proto method set_recorded (|)
    is also<set-recorded>
  { * }

  multi method set_recorded ($_) {
    when .^can('DateTime') { samewith( .DateTime ) }
    when .^can('Int')      { samewith( .Int )      }

    default {
      X::GLib::InvalidType.new(
        message => "Cannot use a { .^name } in a call to {
                    '' }.set_recorded!"
      ).throw;
    }
  }
  multi method set_recorded (DateTime $recorded) {
    samewith($recorded.posix);
  }
  multi method set_recorded (Int $recorded) {
    my gint64 $r = $recorded;

    gdata_youtube_video_set_recorded($!gyv, $r);
  }

}
