use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::Calendar::Event;

use GLib::GList;
use GData::Entry;

use GLib::Roles::Implementor;

our subset GDataCalendarEventAncestry is export of Mu
  where GDataCalendarEvent | GDataEntryAncestry;

class GData::Calendar::Event is GData::Entry {
  has GDataCalendarEvent $!gce is implementor;

  submethod BUILD ( :$gdata-cal-event ) {
    self.setGDataCalendarEvent($gdata-cal-event) if $gdata-cal-event
  }

  method setGDataCalendarEvent (GDataCalendarEventAncestry $_) {
    my $to-parent;

    $!gce = do {
      when GDataCalendarEvent {
        $to-parent = cast(GDataEntry, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataCalendarEvent, $_);
      }
    }
    self.setGDataEntry($to-parent);
  }

  method GData::Raw::Definitions::GDataCalendarEvent
    is also<GDataCalendarEvent>
  { $!gce }

  multi method new (
     $gdata-cal-event where * ~~ GDataCalendarEventAncestry,
    :$ref                                                     = True
  ) {
    return unless $gdata-cal-event;

    my $o = self.bless( :$gdata-cal-event );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $id = Str) {
    my $gdata-cal-event = gdata_calendar_event_new($id);

    $gdata-cal-event ?? self.bless( :$gdata-cal-event ) !! Nil;
  }

  # Type: boolean
  method anyone-can-add-self
    is rw
    is g-property
    is also<anyone_can_add_self>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('anyone-can-add-self', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('anyone-can-add-self', $gv);
      }
    );
  }

  # Type: int64
  method edited ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('edited', $gv);
        my $e = $gv.int64;
        return $e if $raw;
        DateTime.new($e);
      },
      STORE => -> $, Int() $val is copy {
        warn 'edited does not allow writing'
      }
    );
  }

  # Type: boolean
  method guests-can-invite-others
    is rw
    is g-property
    is also<guests_can_invite_others>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('guests-can-invite-others', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('guests-can-invite-others', $gv);
      }
    );
  }

  # Type: boolean
  method guests-can-modify is rw  is g-property is also<guests_can_modify> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('guests-can-modify', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('guests-can-modify', $gv);
      }
    );
  }

  # Type: boolean
  method guests-can-see-guests
    is rw
    is g-property
    is also<guests_can_see_guests>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('guests-can-see-guests', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('guests-can-see-guests', $gv);
      }
    );
  }

  # Type: string
  method original-event-id is rw  is g-property is also<original_event_id> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('original-event-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'original-event-id does not allow writing'
      }
    );
  }

  # Type: string
  method original-event-uri is rw  is g-property is also<original_event_uri> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('original-event-uri', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'original-event-uri does not allow writing'
      }
    );
  }

  # Type: string
  method recurrence is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('recurrence', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('recurrence', $gv);
      }
    );
  }

  # Type: uint
  method sequence is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('sequence', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('sequence', $gv);
      }
    );
  }

  # Type: string
  method status is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('status', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('status', $gv);
      }
    );
  }

  # Type: string
  method transparency is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('transparency', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('transparency', $gv);
      }
    );
  }

  # Type: string
  method uid is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('uid', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('uid', $gv);
      }
    );
  }

  # Type: string
  method visibility is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visibility', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('visibility', $gv);
      }
    );
  }

  method add_person (GDataGDWho() $who) is also<add-person> {
    gdata_calendar_event_add_person($!gce, $who);
  }

  method add_place (GDataGDWhere() $where) is also<add-place> {
    gdata_calendar_event_add_place($!gce, $where);
  }

  method add_time (GDataGDWhen() $when) is also<add-time> {
    gdata_calendar_event_add_time($!gce, $when);
  }

  method get_anyone_can_add_self is also<get-anyone-can-add-self> {
    so gdata_calendar_event_get_anyone_can_add_self($!gce);
  }

  method get_edited is also<get-edited> {
    so gdata_calendar_event_get_edited($!gce);
  }

  method get_guests_can_invite_others is also<get-guests-can-invite-others> {
    so gdata_calendar_event_get_guests_can_invite_others($!gce);
  }

  method get_guests_can_modify is also<get-guests-can-modify> {
    so gdata_calendar_event_get_guests_can_modify($!gce);
  }

  method get_guests_can_see_guests is also<get-guests-can-see-guests> {
    so gdata_calendar_event_get_guests_can_see_guests($!gce);
  }

  method get_is_exception is also<get-is-exception> {
    so gdata_calendar_event_is_exception($!gce);
  }

  proto method get_original_event_details (|)
    is also<get-original-event-details>
  { * }

  multi method get_original_event_details {
    samewith( newCArray(Str), newCArray(Str) );
  }
  multi method get_original_event_details (
    CArray[Str] $event_id,
    CArray[Str] $event_uri
  ) {
    gdata_calendar_event_get_original_event_details($!gce, $event_id, $event_uri);
    ppr($event_id, $event_uri);
  }

  method get_people ( :$raw = False, :gslist(:$glist) = False )
    is also<get-people>
  {
    returnGList(
      gdata_calendar_event_get_people($!gce),
      $raw,
      $glist,
      |GData::GD::Who.getTypePair
    );
  }

  method get_places ( :$raw = False, :gslist(:$glist) = False )
    is also<get-places>
  {
    returnGList(
      gdata_calendar_event_get_places($!gce),
      $raw,
      $glist,
      |GData::GD::Where.getTypePair
    );
  }

  proto method get_primary_time (|)
    is also<get-primary-time>
  { * }

  multi method get_primary_time ( :$raw = False ) {
    samewith( $, $, newCArray(GDataGDWhen) );
  }
  multi method get_primary_time (
                                  $start_time is rw,
                                  $end_time   is rw,
    CArray[Pointer[GDataGDWhen]]  $when,
                                 :$raw               = False
  ) {
    my gint64 ($s, $e) = 0 xx 2;

    gdata_calendar_event_get_primary_time($!gce, $s, $e, $when);
    my $w = propReturnObject( ppr($when), $raw, |GData::GD::When.getTypePair );
    ($start_time, $end_time) = $raw ?? ($s, $e)
                                    !! ($s, $e).map( DateTime.new(*) );
    ($start_time, $end_time, $w);
  }

  method get_recurrence is also<get-recurrence> {
    gdata_calendar_event_get_recurrence($!gce);
  }

  method get_sequence is also<get-sequence> {
    gdata_calendar_event_get_sequence($!gce);
  }

  method get_status is also<get-status> {
    gdata_calendar_event_get_status($!gce);
  }

  method get_times is also<get-times> {
    gdata_calendar_event_get_times($!gce);
  }

  method get_transparency is also<get-transparency> {
    gdata_calendar_event_get_transparency($!gce);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_calendar_event_get_type, $n, $t );
  }

  method get_uid is also<get-uid> {
    gdata_calendar_event_get_uid($!gce);
  }

  method get_visibility is also<get-visibility> {
    gdata_calendar_event_get_visibility($!gce);
  }

  method set_anyone_can_add_self (Int() $anyone_can_add_self)
    is also<set-anyone-can-add-self>
  {
    my gboolean $a = $anyone_can_add_self.so.Int;

    gdata_calendar_event_set_anyone_can_add_self($!gce, $a);
  }

  method set_guests_can_invite_others (Int() $guests_can_invite_others)
    is also<set-guests-can-invite-others>
  {
    my gboolean $g = $guests_can_invite_others.so.Int;

    gdata_calendar_event_set_guests_can_invite_others($!gce, $g);
  }

  method set_guests_can_modify (Int() $guests_can_modify)
    is also<set-guests-can-modify>
  {
    my gboolean $g = $guests_can_modify.so.Int;

    gdata_calendar_event_set_guests_can_modify($!gce, $g);
  }

  method set_guests_can_see_guests (Int() $guests_can_see_guests)
    is also<set-guests-can-see-guests>
  {
    my gboolean $g = $guests_can_see_guests.so.Int;

    gdata_calendar_event_set_guests_can_see_guests($!gce, $g);
  }

  method set_recurrence (Str() $recurrence) is also<set-recurrence> {
    gdata_calendar_event_set_recurrence($!gce, $recurrence);
  }

  method set_sequence (guint() $sequence) is also<set-sequence> {
    gdata_calendar_event_set_sequence($!gce, $sequence);
  }

  method set_status (Str() $status) is also<set-status> {
    gdata_calendar_event_set_status($!gce, $status);
  }

  method set_transparency (Str() $transparency) is also<set-transparency> {
    gdata_calendar_event_set_transparency($!gce, $transparency);
  }

  method set_uid (Str() $uid) is also<set-uid> {
    gdata_calendar_event_set_uid($!gce, $uid);
  }

  method set_visibility (Str() $visibility) is also<set-visibility> {
    gdata_calendar_event_set_visibility($!gce, $visibility);
  }

}
