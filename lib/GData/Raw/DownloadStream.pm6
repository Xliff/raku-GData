use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::DownloadStream;

### /usr/src/libgdata/gdata/gdata-download-stream.h

sub gdata_download_stream_get_authorization_domain (GDataDownloadStream $self)
  returns GDataAuthorizationDomain
  is      native(gdata)
  is      export
{ * }

sub gdata_download_stream_get_cancellable (GDataDownloadStream $self)
  returns GCancellable
  is      native(gdata)
  is      export
{ * }

sub gdata_download_stream_get_content_length (GDataDownloadStream $self)
  returns gssize
  is      native(gdata)
  is      export
{ * }

sub gdata_download_stream_get_content_type (GDataDownloadStream $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_download_stream_get_download_uri (GDataDownloadStream $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_download_stream_get_service (GDataDownloadStream $self)
  returns GDataService
  is      native(gdata)
  is      export
{ * }

sub gdata_download_stream_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_download_stream_new (
  GDataService             $service,
  GDataAuthorizationDomain $domain,
  Str                      $download_uri,
  GCancellable             $cancellable
)
  returns GDataDownloadStream
  is      native(gdata)
  is      export
{ * }
