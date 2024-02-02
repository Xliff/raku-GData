use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::Media::Content;

use GData::Parsable;

use GLib::Roles::Implementor;

our subset GDataMediaContentAncestry is export of Mu
  where GDataMediaContent | GDataParsableAncestry;

class GData::Media::Content is GData::Parsable {
  has GDataMediaContent $!gmc is implementor;

  submethod BUILD ( :$gdata-media-content ) {
    self.setGDataMediaContent($gdata-media-content) if $gdata-media-content;
  }

  method setGDataMediaContent (GDataMediaContentAncestry $_) {
    my $to-parent;

    $!gmc = do {
      when GDataMediaContent {
        $to-parent = cast(GDataParsable, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataMediaContent, $_);
      }
    }
    self.setGDataParsable($to-parent);
  }

  method GData::Raw::Definitions::GDataMediaContent
    is also<GDataMediaContent>
  { $!gmc }

  multi method new (
     $gdata-media-content where * ~~ GDataMediaContentAncestry,
    :$ref                                                       = True
  ) {
    return unless $gdata-media-content;

    my $o = self.bless( :$gdata-media-content );
    $o.ref if $ref;
    $o;
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
        warn 'content-type does not allow writing'
      }
    );
  }

  # Type: int64
  method duration is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('duration', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        warn 'duration does not allow writing'
      }
    );
  }

  # Type: GDataMediaExpression
  method expression is rw  is g-property {
    my $gv = GLib::Value.new( GData::Enum::Media::Expression.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('expression', $gv);
        my $e = $gv.enum;

      },
      STORE => -> $,  $val is copy {
        warn 'expression does not allow writing'
      }
    );
  }

  # Type: ulong
  method filesize is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_ULONG );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('filesize', $gv);
        $gv.ulong;
      },
      STORE => -> $, Int() $val is copy {
        warn 'filesize does not allow writing'
      }
    );
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

  # Type: boolean
  method is-default is rw  is g-property is also<is_default> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-default', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'is-default does not allow writing'
      }
    );
  }

  # Type: GDataMediaMedium
  method medium ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GData::Enums::Media::Medium.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('medium', $gv);
        my $m = $gv.enum;
        return $m unless $enum;
        GDataMediaMediumEnum($m);
      },
      STORE => -> $,  $val is copy {
        warn 'medium does not allow writing'
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
    my $d = gdata_media_content_download(
      $!gmc,
      $service,
      $cancellable,
      $error
    );
    set_error($error);
    propReturnObject($d, $raw, |GData::DownloadStream.getTypePair)
  }

  method get_content_type is also<get-content-type> {
    gdata_media_content_get_content_type($!gmc);
  }

  method get_duration is also<get-duration> {
    gdata_media_content_get_duration($!gmc);
  }

  method get_expression is also<get-expression> {
    gdata_media_content_get_expression($!gmc);
  }

  method get_filesize is also<get-filesize> {
    gdata_media_content_get_filesize($!gmc);
  }

  method get_height is also<get-height> {
    gdata_media_content_get_height($!gmc);
  }

  method get_medium ( :$enum = True ) is also<get-medium> {
    my $m = gdata_media_content_get_medium($!gmc);
    return $m if $enum;
    GDataMediaMediumEnum($m);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_media_content_get_type )
  }

  method get_uri is also<get-uri> {
    gdata_media_content_get_uri($!gmc);
  }

  method get_width is also<get-width> {
    gdata_media_content_get_width($!gmc);
  }

  method get_is_default is also<get-is-default> {
    so gdata_media_content_is_default($!gmc);
  }

}
