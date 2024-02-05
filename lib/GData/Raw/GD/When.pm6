use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::GD::When;

### /usr/src/libgdata/gdata/gd/gdata-gd-when.h

sub gdata_gd_when_add_reminder (
  GDataGDWhen     $self,
  GDataGDReminder $reminder
)
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_when_get_end_time (GDataGDWhen $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_when_get_reminders (GDataGDWhen $self)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_when_get_start_time (GDataGDWhen $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_when_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_when_get_value_string (GDataGDWhen $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_when_is_date (GDataGDWhen $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_when_new (
  gint64   $start_time,
  gint64   $end_time,
  gboolean $is_date
)
  returns GDataGDWhen
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_when_set_end_time (
  GDataGDWhen $self,
  gint64      $end_time
)
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_when_set_is_date (
  GDataGDWhen $self,
  gboolean    $is_date
)
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_when_set_start_time (
  GDataGDWhen $self,
  gint64      $start_time
)
  is      native(gdata)
  is      export
{ * }

sub gdata_gd_when_set_value_string (
  GDataGDWhen $self,
  Str         $value_string
)
  is      native(gdata)
  is      export
{ * }
