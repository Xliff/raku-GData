use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::Picasa::Album;

use GLib::GList;
use GData::Entry;

use GLib::Roles::Implementor;

our subset GDataPicasaWebAlbumAncestry is export of Mu
  where GDataPicasaWebAlbum | GDataEntryAncestry;

class GData::Picasa::Album is GData::Entry {
  has GDataPicasaWebAlbum $!gpa is implementor;

  submethod BUILD ( :$gdata-pic-album ) {
    self.setGDataPicasaWebAlbum($gdata-pic-album) if $gdata-pic-album
  }

  method setGDataPicasaWebAlbum (GDataPicasaWebAlbumAncestry $_) {
    my $to-parent;

    $!gpa = do {
      when GDataPicasaWebAlbum {
        $to-parent = cast(GDataEntry, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataPicasaWebAlbum, $_);
      }
    }
    self.setGDataEntry($to-parent);
  }

  method GData::Raw::Definitions::GDataPicasaWebAlbum
    is also<GDataPicasaWebAlbum>
  { $!gpa }

  multi method new (
     $gdata-pic-album where * ~~ GDataPicasaWebAlbumAncestry,
    :$ref                                                     = True
  ) {
    return unless $gdata-pic-album;

    my $o = self.bless( :$gdata-pic-album );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $id = Str) {
    my $gdata-pic-album = gdata_picasaweb_album_new($id);

    $gdata-pic-album ?? self.bless( :$gdata-pic-album ) !! Nil;
  }

  # Type: string
  method album-id is rw  is g-property is also<album_id> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('album-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('album-id', $gv);
      }
    );
  }

  # Type: long
  method bytes-used is rw  is g-property is also<bytes_used> {
    my $gv = GLib::Value.new( G_TYPE_LONG );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('bytes-used', $gv);
        $gv.long;
      },
      STORE => -> $, Int() $val is copy {
        warn 'bytes-used does not allow writing'
      }
    );
  }

  # Type: uint
  method comment-count is rw  is g-property is also<comment_count> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('comment-count', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'comment-count does not allow writing'
      }
    );
  }

  # Type: int64
  method edited is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('edited', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        warn 'edited does not allow writing'
      }
    );
  }

  # Type: boolean
  method is-commenting-enabled is rw  is g-property is also<is_commenting_enabled> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-commenting-enabled', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('is-commenting-enabled', $gv);
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

  # Type: string
  method nickname is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('nickname', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'nickname does not allow writing'
      }
    );
  }

  # Type: uint
  method num-photos is rw  is g-property is also<num_photos> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('num-photos', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'num-photos does not allow writing'
      }
    );
  }

  # Type: uint
  method num-photos-remaining is rw  is g-property is also<num_photos_remaining> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('num-photos-remaining', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'num-photos-remaining does not allow writing'
      }
    );
  }

  # Type: GDataStrv
  method tags ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tags', $gv);
        my $v = cast(CArray[Str], $gv.pointer);
        return $v if $raw;
        ArrayToCArray($v);
      },
      STORE => -> $,  $val is copy {
        $val .= Array if $val.^can('Array');
        $val = CArrayToArray(Str, $val, :null);
        X::GLib::InvalidType.new(
          message => "Cannot use { .^name } when setting tags, which is {
                      '' }expecting a string array compatible value"
        ).throw;
        $gv.pointer = $val;
        self.prop_set('tags', $gv);
      }
    );
  }

  # Type: int64
  method timestamp is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('timestamp', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int64 = $val;
        self.prop_set('timestamp', $gv);
      }
    );
  }

  # Type: string
  method user is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('user', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'user does not allow writing'
      }
    );
  }

  # Type: GDataPicasawebVisibility
  method visibility ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GDataPicasaWebVisibility );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visibility', $gv);
        my $v = $gv.enum;
        return $v unless $enum;
        GDataPicasaWebVisibilityEnum($v);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GDataPicasaWebVisibility) = $val;
        self.prop_set('visibility', $gv);
      }
    );
  }

  method get_bytes_used is also<get-bytes-used> {
    gdata_picasaweb_album_get_bytes_used($!gpa);
  }

  method get_comment_count is also<get-comment-count> {
    gdata_picasaweb_album_get_comment_count($!gpa);
  }

  method get_contents ( :$raw = False, :gslist(:$glist) = False ) is also<get-contents> {
    returnGList(
      gdata_picasaweb_album_get_contents($!gpa),
      $raw,
      $glist,
      |GData::Media::Content.getTypePair
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
    gdata_picasaweb_album_get_coordinates($!gpa, $lat, $lon);
    ($latitude, $longitude) = ($lat, $lon);
  }

  method get_edited is also<get-edited> {
    so gdata_picasaweb_album_get_edited($!gpa);
  }

  method get_id is also<get-id> {
    gdata_picasaweb_album_get_id($!gpa);
  }

  method get_is_commenting_enabled is also<get-is-commenting-enabled> {
    so gdata_picasaweb_album_is_commenting_enabled($!gpa);
  }

  method get_location is also<get-location> {
    gdata_picasaweb_album_get_location($!gpa);
  }

  method get_nickname is also<get-nickname> {
    gdata_picasaweb_album_get_nickname($!gpa);
  }

  method get_num_photos is also<get-num-photos> {
    gdata_picasaweb_album_get_num_photos($!gpa);
  }

  method get_num_photos_remaining is also<get-num-photos-remaining> {
    gdata_picasaweb_album_get_num_photos_remaining($!gpa);
  }

  method get_tags ( :$raw = False ) is also<get-tags> {
    my $ca = gdata_picasaweb_album_get_tags($!gpa);
    return $ca if $raw;
    CArrayToArray($ca);
  }

  method get_thumbnails ( :$raw = False, :gslist(:$glist) = False ) is also<get-thumbnails> {
    returnGList(
      gdata_picasaweb_album_get_thumbnails($!gpa),
      $raw,
      $glist,
      |GData::Media::Thumbnails.getTypePair
    );
  }

  method get_timestamp ( :$raw = False ) is also<get-timestamp> {
    my $t = gdata_picasaweb_album_get_timestamp($!gpa);
    return $t if $raw;
    DateTime.new($t);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_picasaweb_album_get_type, $n, $t );
  }

  method get_user is also<get-user> {
    gdata_picasaweb_album_get_user($!gpa);
  }

  method get_visibility ( :$enum = True ) is also<get-visibility> {
    my $v = gdata_picasaweb_album_get_visibility($!gpa);
    return $v unless $enum;
    GDataPicasaWebVisibilityEnum($v);
  }

  method set_coordinates (Num() $latitude, Num() $longitude) is also<set-coordinates> {
    my gdouble ($lat, $lon) = ($latitude, $longitude);

    gdata_picasaweb_album_set_coordinates($!gpa, $lat, $lon);
  }

  method set_is_commenting_enabled (Int() $is_commenting_enabled) is also<set-is-commenting-enabled> {
    my gboolean $i = $is_commenting_enabled.so.Int;

    gdata_picasaweb_album_set_is_commenting_enabled($!gpa, $i);
  }

  method set_location (Str() $location) is also<set-location> {
    gdata_picasaweb_album_set_location($!gpa, $location);
  }

  proto method set_tags (|)
    is also<set-tags>
  { * }

  multi method set_tags (@tags) {
    samewith( ArrayToCArray(Str, @tags) );
  }
  multi method set_tags (CArray[Str] $tags) {
    gdata_picasaweb_album_set_tags($!gpa, $tags);
  }

  proto method set_timestamp (|)
    is also<set-timestamp>
  { * }

  multi method set_timestamp ($_) {
    when .^can('DateTime') { samewith( .DateTime ) }
    when .^can('Int')      { samewith( .Int )      }

    default {
      X::GLib::InvalidType.new(
        message => "Cannot use a { .^name } in call to {
                    ''}.set_timestamp"
      ).throw;
    }
  }
  multi method set_timestamp (DateTime $timestamp) {
    samewith( $timestamp.posix );
  }
  multi method set_timestamp (Int $timestamp) {
    my gint64 $t = $timestamp;

    gdata_picasaweb_album_set_timestamp($!gpa, $t);
  }

  method set_visibility (Int() $visibility) is also<set-visibility> {
    my GDataPicasaWebVisibility $v = $visibility;

    gdata_picasaweb_album_set_visibility($!gpa, $v);
  }

}
