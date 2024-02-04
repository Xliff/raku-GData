use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::DownloadStream;

use GIO::InputStream;
use GIO::Cancellable;
use GData::Authorization::Domain;
use GData::Entry;
use GData::Service;

use GLib::Roles::Implementor;

our subset GDataDownloadStreamAncestry is export of Mu
  where GDataDownloadStream | GInputStreamAncestry;

class GData::DownloadStream is GIO::InputStream {
  has GDataDownloadStream $!gds is implementor;

  submethod BUILD ( :$gdata-download ) {
    self.setGDataDownloadStream($gdata-download) if $gdata-download
  }

  method setGDataDownloadStream (GDataDownloadStreamAncestry $_) {
    my $to-parent;

    $!gds = do {
      when GDataDownloadStream {
        $to-parent = cast(GInputStream, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataDownloadStream, $_);
      }
    }
    self.setGInputStream($to-parent);
  }

  method GData::Raw::Definitions::GDataDownloadStream
    is also<GDataDownloadStream>
  { $!gds }

  multi method new (
     $gdata-download where * ~~ GDataDownloadStreamAncestry,
    :$ref                                                    = True
  ) {
    return unless $gdata-download;

    my $o = self.bless( :$gdata-download );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    GDataService()              $service,
    Str()                       $download_uri,
    GDataAuthorizationDomain() :$domain        = GDataAuthorizationDomain,
    GCancellable()             :$cancellable   = GCancellable
  ) {
    samewith(
      $service,
      $domain,
      $download_uri,
      $cancellable
    );
  }
  multi method new (
    GDataService()             $service,
    GDataAuthorizationDomain() $domain,
    Str()                      $download_uri,
    GCancellable()             $cancellable
  ) {
    my $gdata-download = gdata_download_stream_new(
      $service,
      $domain,
      $download_uri,
      $cancellable
    );

    $gdata-download ?? self.bless( :$gdata-download ) !! Nil;
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

  # Type: long
  method content-length is rw  is g-property is also<content_length> {
    my $gv = GLib::Value.new( G_TYPE_LONG );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('content-length', $gv);
        $gv.long;
      },
      STORE => -> $, Int() $val is copy {
        warn 'content-length does not allow writing'
      }
    );
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

  # Type: string
  method download-uri is rw  is g-property is also<download_uri> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('download-uri', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('download-uri', $gv);
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

  method get_authorization_domain ( :$raw = False )
    is also<get-authorization-domain>
  {
    propReturnObject(
      gdata_download_stream_get_authorization_domain($!gds),
      $raw,
      |GData::Authorization::Domain.getTypePair
    );
  }

  method get_cancellable ( :$raw = False )
    is also<get-cancellable>
  {
    propReturnObject(
      gdata_download_stream_get_cancellable($!gds),
      $raw,
      |GIO::Cancellable.getTypePair
    );
  }

  method get_content_length is also<get-content-length> {
    gdata_download_stream_get_content_length($!gds);
  }

  method get_content_type is also<get-content-type> {
    gdata_download_stream_get_content_type($!gds);
  }

  method get_service ( :$raw = False ) is also<get-service> {
    propReturnObject(
      gdata_download_stream_get_service($!gds),
      $raw,
      |GData::Service.getTypePair
    );
  }

  method get_download_uri is also<get-download-uri> {
    gdata_download_stream_get_download_uri($!gds);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gdata_download_stream_get_type,
      $n,
      $t
    );
  }

}
