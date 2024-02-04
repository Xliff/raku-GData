use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::UploadStream;

use GIO::OutputStream;
use GData::Authorization::Domain

use GLib::Roles::Implementor;

our subset GDataUploadStreamAncestry is export of Mu
  where GDataUploadStream | GOutputStreamAncestry;

class GData::UploadStream is GIO::OutputStream {
  has GDataUploadStream $!gus is implementor;

  submethod BUILD ( :$gdata-upload ) {
    self.setGDataUploadStream($gdata-upload) if $gdata-upload
  }

  method setGDataUploadStream (GDataUploadStreamAncestry $_) {
    my $to-parent;

    $!gus = do {
      when GDataUploadStream {
        $to-parent = cast(GOutputStream, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataUploadStream, $_);
      }
    }
    self.setGOutputStream($to-parent);
  }

  method GData::Raw::Definitions::GDataUploadStream
    is also<GDataUploadStream>
  { $!gus }

  multi method new (
     $gdata-upload where * ~~ GDataUploadStreamAncestry,
    :$ref                                                = True
  ) {
    return unless $gdata-upload;

    my $o = self.bless( :$gdata-upload );
    $o.ref if $ref;
    $o;
  }

  multi method new (
     $service,
     $method,
     $upload_uri,
     $slug,
     $content_type,
    :$entry          = GDataEntry,
    :$domain         = GDataAuthorizationDomain,
    :$cancellable    = GCancellable
  ) {
    samewith(
      $service,
      $domain,
      $method,
      $upload_uri,
      $entry,
      $slug,
      $content_type,
      $cancellable
    );
  }
  multi method new (
    GDataService()             $service,
    GDataAuthorizationDomain() $domain,
    Str()                      $method,
    Str()                      $upload_uri,
    GDataEntry()               $entry,
    Str()                      $slug,
    Str()                      $content_type,
    GCancellable()             $cancellable
  ) {
    my $gdata-upload = gdata_upload_stream_new(
      $service,
      $domain,
      $method,
      $upload_uri,
      $entry,
      $slug,
      $content_type,
      $cancellable
    );

    $gdata-upload ?? self.bless( :$gdata-upload ) !! Nil
  }

  proto method new_resumable (|)
    is also<new-resumable>
  { * }

  multi method new_resumable (
     $service,
     $method,
     $upload_uri,
     $slug,
     $content_type,
    :$entry         = GDataEntry,
    :$domain        = GDataAuthorizationDomain,
    :$cancellable   = GCancellable,

    :length(:content_length(:$content-length)) is copy
  ) {
    my $l = $content-length;

    given $entry.content {
      when CArray       { $l //= $entry.content.elems }
      when Blob         { $l //= $entry.chars         }

      when .defined.not { }
    }
    samewith(
      $service,
      $domain,
      $method,
      $upload_uri,
      $entry,
      $slug,
      $content_type,
      $l,
      $cancellable
    );
  }
  multi method new_resumable (
    GDataService()             $service,
    GDataAuthorizationDomain() $domain,
    Str()                      $method,
    Str()                      $upload_uri,
    GDataEntry()               $entry,
    Str()                      $slug,
    Str()                      $content_type,
    Int()                      $content_length,
    GCancellable()             $cancellable
  ) {
    my goffset $c = $content_length;

    my $gdata-upload = gdata_upload_stream_new_resumable(
      $service,
      $domain,
      $method,
      $upload_uri,
      $entry,
      $slug,
      $content_type,
      $c,
      $cancellable
    );

    $gdata-upload ?? self.bless( :$gdata-upload ) !! Nil
  }

  # Type: GDataAuthorizationDomain
  method authorization-domain ( :$raw = False )
    is rw
    is g-property
    is also<authorization_domain>
  {
    my $gv = GLib::Value.new( GData::Authorization::Domain.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('authorization-domain', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          GData::Authorization::Domain.getTypePair
        );
      },
      STORE => -> $, GDataAuthorizationDomain() $val is copy {
        $gv.object = $val;
        self.prop_set('authorization-domain', $gv);
      }
    );
  }

  # Type: GCancellable
  method cancellable ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::Cancellable.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('cancellable', $gv);
        propReturnObject($gv.object, $raw, |GIO::Cancellable.getTypePair);
      },
      STORE => -> $, GCancellable() $val is copy {
        $gv.object = $val;
        self.prop_set('cancellable', $gv);
      }
    );
  }

  # Type: int64
  method content-length
    is rw
    is g-property
    is also<content_length>
  {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('content-length', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int64 = $val;
        self.prop_set('content-length', $gv);
      }
    );
  }

  # Type: string
  method content-type
    is rw
    is g-property
    is also<content_type>
  {
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

  # Type: GDataEntry
  method entry ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GData::Entry.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('entry', $gv);
        propReturnObject($gv.object, $raw, |GData::Entry.getTypePair);
      },
      STORE => -> $, GDataEntry() $val is copy {
        $gv.object = $val;
        self.prop_set('entry', $gv);
      }
    );
  }

  # Type: string
  method method is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('method', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('method', $gv);
      }
    );
  }

  # Type: GDataService
  method service ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GData::Service.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('service', $gv);
        propReturnObject($gv.object, $raw, |GData::Service.getTypePair)
      },
      STORE => -> $, GDataService() $val is copy {
        $gv.object = $val;
        self.prop_set('service', $gv);
      }
    );
  }

  # Type: string
  method slug is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('slug', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('slug', $gv);
      }
    );
  }

  # Type: string
  method upload-uri is rw  is g-property is also<upload_uri> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('upload-uri', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('upload-uri', $gv);
      }
    );
  }

  method get_authorization_domain ( :$raw = False )
    is also<get-authorization-domain>
  {
    propReturnObject(
      gdata_upload_stream_get_authorization_domain($!gus),
      $raw,
      |GData::Authorization::Domain.getTypePair
    );
  }

  method get_cancellable ( :$raw = False )
    is also<get-cancellable>
  {
    propReturnObject(
      gdata_upload_stream_get_cancellable($!gus),
      $raw,
      |GIO::Cancellable.getTypePair
    );
  }

  method get_content_length is also<get-content-length> {
    gdata_upload_stream_get_content_length($!gus);
  }

  method get_content_type is also<get-content-type> {
    gdata_upload_stream_get_content_type($!gus);
  }

  method get_entry ( :$raw = False ) is also<get-entry> {
    propReturnObject(
      gdata_upload_stream_get_entry($!gus),
      $raw,
      |GData::Entry.getTypePair
    )
  }

  method get_method is also<get-method> {
    gdata_upload_stream_get_method($!gus);
  }

  proto method get_response (|)
    is also<get-response>
  { * }

  multi method get_response {
    samewith($);
  }
  multi method get_response ($length is rw, :$raw = False) {
    my gssize $l = 0;

    my $r = gdata_upload_stream_get_response($!gus, $l);
    $length = $l;
    return $r if $raw;
    Buf.new( $r[^$l] )
  }

  method get_service ( :$raw = False ) is also<get-service> {
    propReturnObject(
      gdata_upload_stream_get_service($!gus),
      $raw,
      |GData::Service.getTypePair
    );
  }

  method get_slug is also<get-slug> {
    gdata_upload_stream_get_slug($!gus);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gdata_upload_stream_get_type,
      $n,
      $t
    );
  }

  method get_upload_uri is also<get-upload-uri> {
    gdata_upload_stream_get_upload_uri($!gus);
  }

}
