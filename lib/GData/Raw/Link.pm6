use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::Link;

### /usr/src/libgdata/gdata/atom/gdata-link.h

sub gdata_link_get_content_type (GDataLink $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_link_get_language (GDataLink $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_link_get_length (GDataLink $self)
  returns gint
  is      native(gdata)
  is      export
{ * }

sub gdata_link_get_relation_type (GDataLink $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_link_get_title (GDataLink $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_link_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_link_get_uri (GDataLink $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_link_new (
  Str $uri,
  Str $relation_type
)
  returns GDataLink
  is      native(gdata)
  is      export
{ * }

sub gdata_link_set_content_type (
  GDataLink $self,
  Str       $content_type
)
  is      native(gdata)
  is      export
{ * }

sub gdata_link_set_language (
  GDataLink $self,
  Str       $language
)
  is      native(gdata)
  is      export
{ * }

sub gdata_link_set_length (
  GDataLink $self,
  gint      $length
)
  is      native(gdata)
  is      export
{ * }

sub gdata_link_set_relation_type (
  GDataLink $self,
  Str       $relation_type
)
  is      native(gdata)
  is      export
{ * }

sub gdata_link_set_title (
  GDataLink $self,
  Str       $title
)
  is      native(gdata)
  is      export
{ * }

sub gdata_link_set_uri (
  GDataLink $self,
  Str       $uri
)
  is      native(gdata)
  is      export
{ * }
