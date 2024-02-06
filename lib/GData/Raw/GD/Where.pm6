use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::GD::Where;

### /home/cbwood/sources/libgdata/gdata/gd/gdata-gd-where.h

sub gdata_gd_where_get_label (GDataGDWhere $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_where_get_relation_type (GDataGDWhere $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_where_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_where_get_value_string (GDataGDWhere $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_where_new (
  Str $relation_type,
  Str $value_string,
  Str $label
)
  returns GDataGDWhere
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_where_set_label (
  GDataGDWhere $self,
  Str          $label
)
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_where_set_relation_type (
  GDataGDWhere $self,
  Str          $relation_type
)
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_where_set_value_string (
  GDataGDWhere $self,
  Str          $value_string
)
  is      native(gdata)
  is      export
{ * }
