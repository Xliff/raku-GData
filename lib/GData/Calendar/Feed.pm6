use v6.c;

use Method::Also;
use GData::Raw::Types;
use GData::Raw::Feed;

use GLib::GList;
use GData::Feed;
use GData::Calendar::Calendar;

use GLib::Roles::Implementor;

### /usr/src/libgdata/gdata/services/Calendar/gdata-Calendar-feed.h

our subset GDataCalendarFeedAncestry is export of Mu
  where GDataCalendarFeed | GDataFeedAncestry;

class GData::Calendar::Feed is GData::Feed {
  has GDataCalendarFeed $!gyf is implementor;

  submethod BUILD ( :$gdata-calfeed ) {
    self.setGDataCalendarFeed($gdata-calfeed) if $gdata-calfeed
  }

  method setGDataCalendarFeed (GDataCalendarFeedAncestry $_) {
    my $to-parent;

    $!gyf = do {
      when GDataCalendarFeed {
        $to-parent = cast(GDataFeed, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataCalendarFeed, $_);
      }
    }
    self.setGDataFeed($to-parent);
  }

  method GData::Raw::Structs::GDataCalendarFeed
    is also<GDataCalendarFeed>
  { $!gyf }

  multi method new (
     $gdata-calfeed where * ~~ GDataCalendarFeedAncestry,
    :$ref                                                = True
  ) {
    return unless $gdata-calfeed;

    my $o = self.bless( :$gdata-calfeed );
    $o.ref if $ref;
    $o;
  }

  method get_entries ( :$raw = False, :gslist(:$glist) = False )
    is also<
      get-entries
      entries
    >
  {
    my $e = returnGList(
      gdata_feed_get_entries(self.GDataFeed),
      $raw,
      $glist,
      |GData::Calendar::Calendar.getTypePair
    );

  }

  method get_type {
    state ($n, $t);

    sub gdata_Calendar_feed_get_type
      returns GType
      is native(gdata)
    { * }

    unstable_get_type( self.^name, &gdata_Calendar_feed_get_type, $n, $t );
  }

  method look_up_entry (Str() $id, :$raw = False) is also<look-up-entry> {
    propReturnObject(
      gdata_feed_look_up_entry(self.GDataFeed, $id),
      $raw,
      |GData::Calendar::Calendar.getTypePair
    );
  }

}
