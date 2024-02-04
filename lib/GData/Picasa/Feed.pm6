use v6.c;

use Method::Also;
use GData::Raw::Types;
use GData::Raw::Feed;

use GLib::GList;
use GData::Feed;
use GData::Picasa::Album;

use GLib::Roles::Implementor;

### /usr/src/libgdata/gdata/services/picasaweb/gdata-picasaweb-feed.h

our subset GDataPicasaWebFeedAncestry is export of Mu
  where GDataPicasaWebFeed | GDataFeedAncestry;

class GData::Picasa::Feed is GData::Feed {
  has GDataPicasaWebFeed $!gpf is implementor;

  submethod BUILD ( :$gdata-picfeed ) {
    self.setGDataPicasaWebFeed($gdata-picfeed) if $gdata-picfeed
  }

  method setGDataPicasaWebFeed (GDataPicasaWebFeedAncestry $_) {
    my $to-parent;

    $!gpf = do {
      when GDataPicasaWebFeed {
        $to-parent = cast(GDataFeed, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataPicasaWebFeed, $_);
      }
    }
    self.setGDataFeed($to-parent);
  }

  method GData::Raw::Structs::GDataPicasaWebFeed
    is also<GDataPicasaWebFeed>
  { $!gpf }

  multi method new (
     $gdata-picfeed where * ~~ GDataPicasaWebFeedAncestry,
    :$ref                                                = True
  ) {
    return unless $gdata-picfeed;

    my $o = self.bless( :$gdata-picfeed );
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
      |GData::PicasaWeb::Video.getTypePair
    );

  }

  method get_type {
    state ($n, $t);

    sub gdata_PicasaWeb_feed_get_type
      returns GType
      is native(gdata)
    { * }

    unstable_get_type( self.^name, &gdata_PicasaWeb_feed_get_type, $n, $t );
  }

  method look_up_entry (Str() $id, :$raw = False) is also<look-up-entry> {
    propReturnObject(
      gdata_feed_look_up_entry(self.GDataFeed, $id),
      $raw,
      |GData::PicasaWeb::Video.getTypePair
    );
  }

}
