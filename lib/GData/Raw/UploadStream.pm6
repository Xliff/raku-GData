use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GIO::Raw::Structs;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::UploadStream;

### /usr/src/libgdata/gdata/gdata-upload-stream.h

sub gdata_upload_stream_get_authorization_domain (GDataUploadStream $self)
  returns GDataAuthorizationDomain
  is      native(gdata)
  is      export
{ * }

sub gdata_upload_stream_get_cancellable (GDataUploadStream $self)
  returns GCancellable
  is      native(gdata)
  is      export
{ * }

sub gdata_upload_stream_get_content_length (GDataUploadStream $self)
  returns goffset
  is      native(gdata)
  is      export
{ * }

sub gdata_upload_stream_get_content_type (GDataUploadStream $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_upload_stream_get_entry (GDataUploadStream $self)
  returns GDataEntry
  is      native(gdata)
  is      export
{ * }

sub gdata_upload_stream_get_method (GDataUploadStream $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_upload_stream_get_response (
  GDataUploadStream $self,
  gssize            $length is rw
)
  returns CArray[uint8]
  is      native(gdata)
  is      export
{ * }

sub gdata_upload_stream_get_service (GDataUploadStream $self)
  returns GDataService
  is      native(gdata)
  is      export
{ * }

sub gdata_upload_stream_get_slug (GDataUploadStream $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_upload_stream_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_upload_stream_get_upload_uri (GDataUploadStream $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_upload_stream_new (
  GDataService             $service,
  GDataAuthorizationDomain $domain,
  Str                      $method,
  Str                      $upload_uri,
  GDataEntry               $entry,
  Str                      $slug,
  Str                      $content_type,
  GCancellable             $cancellable
)
  returns GOutputStream
  is      native(gdata)
  is      export
{ * }

sub gdata_upload_stream_new_resumable (
  GDataService             $service,
  GDataAuthorizationDomain $domain,
  Str                      $method,
  Str                      $upload_uri,
  GDataEntry               $entry,
  Str                      $slug,
  Str                      $content_type,
  goffset                  $content_length,
  GCancellable             $cancellable
)
  returns GOutputStream
  is      native(gdata)
  is      export
{ * }
