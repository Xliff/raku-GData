use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Enums;
use GData::Raw::Structs;

unit package GData::Raw::Picasa::Query;

### /usr/src/libgdata/gdata/services/picasaweb/gdata-picasaweb-query.h

sub gdata_picasaweb_query_get_bounding_box (
  GDataPicasaWebQuery $self,
  gdouble             $north is rw,
  gdouble             $east is rw,
  gdouble             $south is rw,
  gdouble             $west is rw
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_query_get_image_size (GDataPicasaWebQuery $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_query_get_location (GDataPicasaWebQuery $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_query_get_tag (GDataPicasaWebQuery $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_query_get_thumbnail_size (GDataPicasaWebQuery $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_query_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_query_get_visibility (GDataPicasaWebQuery $self)
  returns GDataPicasaWebVisibility
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_query_new (Str $q)
  returns GDataPicasaWebQuery
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_query_new_with_limits (
  Str   $q,
  guint $start_index,
  guint $max_results
)
  returns GDataPicasaWebQuery
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_query_set_bounding_box (
  GDataPicasaWebQuery $self,
  gdouble             $north,
  gdouble             $east,
  gdouble             $south,
  gdouble             $west
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_query_set_image_size (
  GDataPicasaWebQuery $self,
  Str                 $image_size
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_query_set_location (
  GDataPicasaWebQuery $self,
  Str                 $location
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_query_set_tag (
  GDataPicasaWebQuery $self,
  Str                 $tag
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_query_set_thumbnail_size (
  GDataPicasaWebQuery $self,
  Str                 $thumbnail_size
)
  is      native(gdata)
  is      export
{ * }

sub gdata_picasaweb_query_set_visibility (
  GDataPicasaWebQuery      $self,
  GDataPicasaWebVisibility $visibility
)
  is      native(gdata)
  is      export
{ * }
