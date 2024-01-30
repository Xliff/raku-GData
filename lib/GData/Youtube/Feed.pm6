use v6.c;

use Method::Also;
use GData::Raw::Types;

use GLib::Roles::Implementor;

our subset GDataYouTubeFeedAncestry is export of Mu
  where GDataYouTubeFeed | GDataFeedAncestry;

class GData::Youtube::Feed is GData::Feed {
  has GDataYouTubeFeed $!gyf is implementor;

  submethod BUILD ( :$gdata-youfeed ) {
    self.setGDataYouTubeFeed($gdata-youfeed) if $gdata-youfeed
  }

  method setGDataYouTubeFeed (GDataYouTubeFeedAncestry $_) {
    my $to-parent;

    $!gyf = do {
      when GDataYouTubeFeed {
        $to-parent = cast(GDataFeed, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataYouTubeFeed, $_);
      }
    }
    self.setGDataFeed($to-parent);
  }

  method GData::Raw::Definitions::GDataYouTubeFeed
    is also<GDataYouTubeFeed>
  { $!gyf }

  multi method new (
     $gdata-youfeed where * ~~ GDataYouTubeFeedAncestry,
    :$ref                                                = True
  ) {
    return unless $gdata-youfeed;

    my $o = self.bless( :$gdata-youfeed );
    $o.ref if $ref;
    $o;
  }

  method get_type {
    state ($n, $t);

    sub gdata_youtube_feed_get_type
      returns GType
      is native(gdata)
    { * }

    unstable_get_type( self.^name, &gdata_youtube_feed_get_type, $n, $t );
  }

}
