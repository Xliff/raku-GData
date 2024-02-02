use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Enums;
use GData::Raw::Structs;

unit package GData::Raw::Media::Content;

### /usr/src/libgdata/gdata/media/gdata-media-content.h

sub gdata_media_content_download (
  GDataMediaContent       $self,
  GDataService            $service,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDataDownloadStream
  is      native(gdata)
  is      export
{ * }

sub gdata_media_content_get_content_type (GDataMediaContent $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_media_content_get_duration (GDataMediaContent $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_media_content_get_expression (GDataMediaContent $self)
  returns GDataMediaExpression
  is      native(gdata)
  is      export
{ * }

sub gdata_media_content_get_filesize (GDataMediaContent $self)
  returns gsize
  is      native(gdata)
  is      export
{ * }

sub gdata_media_content_get_height (GDataMediaContent $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_media_content_get_medium (GDataMediaContent $self)
  returns GDataMediaMedium
  is      native(gdata)
  is      export
{ * }

sub gdata_media_content_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_media_content_get_uri (GDataMediaContent $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_media_content_get_width (GDataMediaContent $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_media_content_is_default (GDataMediaContent $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }
