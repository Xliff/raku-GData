use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::GD::Who;

### /usr/src/libgdata/gdata/gd/gdata-gd-who.h

sub gdata_gd_who_get_email_address (GDataGDWho $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_who_get_relation_type (GDataGDWho $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_who_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_who_get_value_string (GDataGDWho $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_who_new (
  Str $relation_type,
  Str $value_string,
  Str $email_address
)
  returns GDataGDWho
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_who_set_email_address (
  GDataGDWho $self,
  Str        $email_address
)
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_who_set_relation_type (
  GDataGDWho $self,
  Str        $relation_type
)
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_who_set_value_string (
  GDataGDWho $self,
  Str        $value_string
)
  is      native(gdata)
  is      export
{ * }
