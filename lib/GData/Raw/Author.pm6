use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::Author;

### /usr/src/libgdata/gdata/atom/gdata-author.h

sub gdata_author_get_email_address (GDataAuthor $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_author_get_name (GDataAuthor $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_author_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_author_get_uri (GDataAuthor $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_author_new (
  Str $name,
  Str $uri,
  Str $email_address
)
  returns GDataAuthor
  is      native(gdata)
  is      export
{ * }

sub gdata_author_set_email_address (
  GDataAuthor $self,
  Str         $email_address
)
  is      native(gdata)
  is      export
{ * }

sub gdata_author_set_name (
  GDataAuthor $self,
  Str         $name
)
  is      native(gdata)
  is      export
{ * }

sub gdata_author_set_uri (
  GDataAuthor $self,
  Str         $uri
)
  is      native(gdata)
  is      export
{ * }
