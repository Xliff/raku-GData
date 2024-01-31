use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GData::Raw::Definitions;
use GData::Raw::Enums;
use GData::Raw::Structs;

unit package GData::Raw::Picasa::Album;

### /usr/src/libgdata/gdata/services/picasaweb/gdata-picasaweb-album.h

sub gdata_picasaweb_album_get_bytes_used (GDataPicasaWebAlbum $self)
  returns glong
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_get_comment_count (GDataPicasaWebAlbum $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_get_contents (GDataPicasaWebAlbum $self)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_get_coordinates (
  GDataPicasaWebAlbum $self,
  gdouble             $latitude is rw,
  gdouble             $longitude is rw
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_get_edited (GDataPicasaWebAlbum $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_get_id (GDataPicasaWebAlbum $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_get_location (GDataPicasaWebAlbum $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_get_nickname (GDataPicasaWebAlbum $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_get_num_photos (GDataPicasaWebAlbum $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_get_num_photos_remaining (GDataPicasaWebAlbum $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_get_tags (GDataPicasaWebAlbum $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_get_thumbnails (GDataPicasaWebAlbum $self)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_get_timestamp (GDataPicasaWebAlbum $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_get_user (GDataPicasaWebAlbum $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_get_visibility (GDataPicasaWebAlbum $self)
  returns GDataPicasaWebVisibility
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_is_commenting_enabled (GDataPicasaWebAlbum $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_new (Str $id)
  returns GDataPicasaWebAlbum
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_set_coordinates (
  GDataPicasaWebAlbum $self,
  gdouble             $latitude,
  gdouble             $longitude
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_set_is_commenting_enabled (
  GDataPicasaWebAlbum $self,
  gboolean            $is_commenting_enabled
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_set_location (
  GDataPicasaWebAlbum $self,
  Str                 $location
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_set_tags (
  GDataPicasaWebAlbum $self,
  CArray[Str]         $tags
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_set_timestamp (
  GDataPicasaWebAlbum $self,
  gint64              $timestamp
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_album_set_visibility (
  GDataPicasaWebAlbum      $self,
  GDataPicasaWebVisibility $visibility
)
  is      native(gdata)
  is      export
{ * }
