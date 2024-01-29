use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::Parsable;

### /usr/src/libgdata/gdata/gdata-parsable.h

sub gdata_parsable_get_content_type (GDataParsable $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_parsable_get_json (GDataParsable $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_parsable_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_parsable_get_xml (GDataParsable $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_parsable_new_from_json (
  GType                   $parsable_type,
  CArray[uint8]           $json,
  gint                    $length,
  CArray[Pointer[GError]] $error
)
  returns GDataParsable
  is      native(gdata)
  is      export
{ * }

sub gdata_parsable_new_from_xml (
  GType                   $parsable_type,
  CArray[uint8]           $xml,
  gint                    $length,
  CArray[Pointer[GError]] $error
)
  returns GDataParsable
  is      native(gdata)
  is      export
{ * }
