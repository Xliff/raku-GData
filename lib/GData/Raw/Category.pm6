use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::Category;

### /usr/src/libgdata/gdata/atom/gdata-category.h

sub gdata_category_get_label (GDataCategory $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_category_get_scheme (GDataCategory $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_category_get_term (GDataCategory $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_category_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_category_new (
  Str $term,
  Str $scheme,
  Str $label
)
  returns GDataCategory
  is      native(gdata)
  is      export
{ * }

sub gdata_category_set_label (
  GDataCategory $self,
  Str           $label
)
  is      native(gdata)
  is      export
{ * }

sub gdata_category_set_scheme (
  GDataCategory $self,
  Str           $scheme
)
  is      native(gdata)
  is      export
{ * }

sub gdata_category_set_term (
  GDataCategory $self,
  Str           $term
)
  is      native(gdata)
  is      export
{ * }
