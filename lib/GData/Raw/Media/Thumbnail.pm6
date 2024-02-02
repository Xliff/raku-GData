use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Enums;
use GData::Raw::Structs;

unit package GData::Raw::Media::Thumbnail;

### /usr/src/libgdata/gdata/media/gdata-media-thumbnail.h

sub gdata_media_thumbnail_download (
  GDataMediaThumbnail     $self,
  GDataService            $service,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDataDownloadStream
  is      native(gdata)
  is      export
{ * }

sub gdata_media_thumbnail_get_height (GDataMediaThumbnail $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_media_thumbnail_get_time (GDataMediaThumbnail $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_media_thumbnail_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_media_thumbnail_get_uri (GDataMediaThumbnail $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_media_thumbnail_get_width (GDataMediaThumbnail $self)
  returns guint
  is      native(gdata)
  is      export
{ * }
