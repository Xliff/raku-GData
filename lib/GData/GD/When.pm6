use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::GD::When;

use GLib::GList;
use GData::Parsable;

use GLib::Roles::Implementor;

our subset GDataGDWhenAncestry is export of Mu
  where GDataGDWhen | GDataParsableAncestry;

class GData::GD::When is GData::Parsable {
  has GDataGDWhen $!gdw is implementor;

  submethod BUILD ( :$gdata-gd-when ) {
    self.setGDataGDWhen($gdata-gd-when) if $gdata-gd-when
  }

  method setGDataGDWhen (GDataGDWhenAncestry $_) {
    my $to-parent;

    $!gdw = do {
      when GDataGDWhen {
        $to-parent = cast(GDataParsable, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataGDWhen, $_);
      }
    }
    self.setGDataParsable($to-parent);
  }

  method GData::Raw::Structs::GDataGDWhen
    is also<GDataGDWhen>
  { $!gdw }

  multi method new (
     $gdata-gd-when where * ~~ GDataGDWhenAncestry,
    :$ref                                           = True
  ) {
    return unless $gdata-gd-when;

    my $o = self.bless( :$gdata-gd-when );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $start_time, Int() $end_time, Int() $is_date) {
    my gint64   ($s, $e) = ($start_time, $end_time);
    my gboolean  $i      =  $is_date.so.Int;

    my $gdata-gd-when = gdata_gd_when_new($s, $e, $i);

    $gdata-gd-when ?? self.bless( :$gdata-gd-when ) !! Nil;
  }

  # Type: int64
  method end-time ( :$raw = False ) is rw  is g-property is also<end_time> {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('end-time', $gv);
        my $t = $gv.int64;
        return $t if $raw;
        DateTime.new($t);
      },
      STORE => -> $, Int() $val is copy {
        $gv.int64 = $val;
        self.prop_set('end-time', $gv);
      }
    );
  }

  # Type: boolean
  method is-date is rw  is g-property is also<is_date> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-date', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('is-date', $gv);
      }
    );
  }

  # Type: int64
  method start-time ( :$raw = False )
    is rw
    is g-property
    is also<start_time>
  {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('start-time', $gv);
        my $t = $gv.int64;
        return $t if $raw;
        DateTime.new($t);
      },
      STORE => -> $, Int() $val is copy {
        $gv.int64 = $val;
        self.prop_set('start-time', $gv);
      }
    );
  }

  # Type: string
  method value-string is rw  is g-property is also<value_string> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('value-string', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('value-string', $gv);
      }
    );
  }

  method add_reminder (GDataGDReminder() $reminder) is also<add-reminder> {
    gdata_gd_when_add_reminder($!gdw, $reminder);
  }

  method get_is_date is also<get-is-date> {
    so gdata_gd_when_is_date($!gdw);
  }

  method get_end_time ( :$raw = False ) is also<get-end-time> {
    my $e = gdata_gd_when_get_end_time($!gdw);
    return $e if $raw;
    DateTime.new($e);
  }

  method get_reminders ( :$raw = False, :gslist(:$glist) = False )
    is also<get-reminders>
  {
    returnGList(
      gdata_gd_when_get_reminders($!gdw),
      $raw,
      $glist,
      |GData::GD::Reminder.getTypePair
    );
  }

  method get_start_time ( :$raw = False ) is also<get-start-time> {
    my $s = gdata_gd_when_get_start_time($!gdw);
    return $s if $raw;
    DateTime.new($s);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_gd_when_get_type, $n, $t );
  }

  method get_value_string is also<get-value-string> {
    gdata_gd_when_get_value_string($!gdw);
  }

  method set_end_time (Int() $end_time) is also<set-end-time> {
    my gint64 $e = $end_time;

    gdata_gd_when_set_end_time($!gdw, $e);
  }

  method set_is_date (Int() $is_date) is also<set-is-date> {
    my gboolean $i = $is_date.so.Int;

    gdata_gd_when_set_is_date($!gdw, $i);
  }

  method set_start_time (Int() $start_time) is also<set-start-time> {
    my gint64 $s = $start_time;

    gdata_gd_when_set_start_time($!gdw, $s);
  }

  method set_value_string (Str() $value_string) is also<set-value-string> {
    gdata_gd_when_set_value_string($!gdw, $value_string);
  }

}
