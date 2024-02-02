use v6.c;

use NativeCall;
use Method::Also;

use GData::Raw::Types;
use GData::Raw::Media::Thumbnail;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GDataMediaThumbnailAncestry is export of Mu
  where GDataMediaThumbnail | GObject;

class GData::Media::Thumbnail {
  also does GLib::Roles::Object;

  has GDataMediaThumbnail $!gmt is implementor;

  submethod BUILD ( :$gdata-media-thumb ) {
    self.setGDataMediaThumbnail($gdata-media-thumb) if $gdata-media-thumb
  }

  method setGDataMediaThumbnail (GDataMediaThumbnailAncestry $_) {
    my $to-parent;

    $!gmt = do {
      when GDataMediaThumbnail {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataMediaThumbnail, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GData::Raw::Definitions::GDataMediaThumbnail
    is also<GDataMediaThumbnail>
  { $!gmt }

  multi method new (
     $gdata-media-thumb where * ~~ GDataMediaThumbnailAncestry,
    :$ref                                                       = True
  ) {
    return unless $gdata-media-thumb;

    my $o = self.bless( :$gdata-media-thumb );
    $o.ref if $ref;
    $o;
  }

  # Type: uint
  method height is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('height', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'height does not allow writing'
      }
    );
  }

  # Type: int64
  method time is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('time', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        warn 'time does not allow writing'
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
        warn 'uri does not allow writing'
      }
    );
  }

  # Type: uint
  method width is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('width', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'width does not allow writing'
      }
    );
  }

  method download (
    GDataService()           $service,
    GCancellable()           $cancellable = GCancellable,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$raw         = False
  ) {
    clear_error;
    my $d = gdata_media_thumbnail_download(
      $!gmt,
      $service,
      $cancellable,
      $error
    );
    set_error($error);
    propReturnObject($d, $raw, |GData::DownloadStream.getType);
  }

  method get_height is also<get-height> {
    gdata_media_thumbnail_get_height($!gmt);
  }

  method get_time is also<get-time> {
    gdata_media_thumbnail_get_time($!gmt);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_media_thumbnail_get_type, $n, $t );
  }

  method get_uri is also<get-uri> {
    gdata_media_thumbnail_get_uri($!gmt);
  }

  method get_width is also<get-width> {
    gdata_media_thumbnail_get_width($!gmt);
  }

}
