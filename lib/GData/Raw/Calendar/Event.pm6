use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::Calendar::Event;

### /usr/src/libgdata/gdata/services/calendar/gdata-calendar-event.h

sub gdata_calendar_event_add_person (
  GDataCalendarEvent $self,
  GDataGDWho         $who
)
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_add_place (
  GDataCalendarEvent $self,
  GDataGDWhere       $where
)
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_add_time (
  GDataCalendarEvent $self,
  GDataGDWhen        $when
)
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_anyone_can_add_self (GDataCalendarEvent $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_edited (GDataCalendarEvent $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_guests_can_invite_others (GDataCalendarEvent $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_guests_can_modify (GDataCalendarEvent $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_guests_can_see_guests (GDataCalendarEvent $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_original_event_details (
  GDataCalendarEvent $self,
  CArray[Str]        $event_id,
  CArray[Str]        $event_uri
)
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_people (GDataCalendarEvent $self)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_places (GDataCalendarEvent $self)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_primary_time (
  GDataCalendarEvent  $self,
  gint64              $start_time is rw,
  gint64              $end_time is rw,
  CArray[GDataGDWhen] $when
)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_recurrence (GDataCalendarEvent $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_sequence (GDataCalendarEvent $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_status (GDataCalendarEvent $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_times (GDataCalendarEvent $self)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_transparency (GDataCalendarEvent $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_uid (GDataCalendarEvent $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_get_visibility (GDataCalendarEvent $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_is_exception (GDataCalendarEvent $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_new (Str $id)
  returns GDataCalendarEvent
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_set_anyone_can_add_self (
  GDataCalendarEvent $self,
  gboolean           $anyone_can_add_self
)
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_set_guests_can_invite_others (
  GDataCalendarEvent $self,
  gboolean           $guests_can_invite_others
)
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_set_guests_can_modify (
  GDataCalendarEvent $self,
  gboolean           $guests_can_modify
)
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_set_guests_can_see_guests (
  GDataCalendarEvent $self,
  gboolean           $guests_can_see_guests
)
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_set_recurrence (
  GDataCalendarEvent $self,
  Str                $recurrence
)
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_set_sequence (
  GDataCalendarEvent $self,
  guint              $sequence
)
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_set_status (
  GDataCalendarEvent $self,
  Str                $status
)
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_set_transparency (
  GDataCalendarEvent $self,
  Str                $transparency
)
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_set_uid (
  GDataCalendarEvent $self,
  Str                $uid
)
  is      native(gdata)
  is      export
{ * }

sub gdata_calendar_event_set_visibility (
  GDataCalendarEvent $self,
  Str                $visibility
)
  is      native(gdata)
  is      export
{ * }
