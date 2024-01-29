use v6.c;

use Method::Also;

use GData::Raw::Types;
use GData::Raw::Feed;

# use GData::Author;
# use GData::Category;
use GData::Entry;
# use GData::Generator;
# use GData::Link;
use GData::Parseable;

use GLib::Roles::Implementor;


our subset GDataFeedAncestry is export of Mu
  where GDataFeed | GDataParseableAncestry;

class GData::Feed is GData::Parseable {
  has GDataFeed $!gf is implementor;

  submethod BUILD ( :$gdata-feed ) {
    self.setGDataFeed($gdata-feed) if $gdata-feed
  }

  method setGDataFeed (GDataFeedAncestry $_) {
    my $to-parent;

    $!gf = do {
      when GDataFeed {
        $to-parent = cast(GDataParseable, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataFeed, $_);
      }
    }
    self.setGDataParseable($to-parent);
  }

  method GData::Raw::Definitions::GDataFeed
    is also<GDataFeed>
  { $!gf }

  multi method new ($gdata-feed where * ~~ GDataFeedAncestry , :$ref = True) {
    return unless $gdata-feed;

    my $o = self.bless( :$gdata-feed );
    $o.ref if $ref;
    $o;
  }

  # Type: string
  method etag is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('etag', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'etag does not allow writing'
      }
    );
  }

  # Type: GDataGenerator
  method generator is rw  is g-property {
    my $gv = GLib::Value.new( GData::Generator.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('generator', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GData::Generator.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'generator does not allow writing'
      }
    );
  }

  # Type: string
  method icon is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'icon does not allow writing'
      }
    );
  }

  # Type: string
  method id is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'id does not allow writing'
      }
    );
  }

  # Type: uint
  method items-per-page is rw  is g-property is also<items_per_page> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('items-per-page', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'items-per-page does not allow writing'
      }
    );
  }

  # Type: string
  method logo is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('logo', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'logo does not allow writing'
      }
    );
  }

  # Type: string
  method next-page-token is rw  is g-property is also<next_page_token> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('next-page-token', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'next-page-token does not allow writing'
      }
    );
  }

  # Type: string
  method rights is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('rights', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'rights does not allow writing'
      }
    );
  }

  # Type: uint
  method start-index is rw  is g-property is also<start_index> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('start-index', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'start-index does not allow writing'
      }
    );
  }

  # Type: string
  method subtitle is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('subtitle', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'subtitle does not allow writing'
      }
    );
  }

  # Type: string
  method title is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'title does not allow writing'
      }
    );
  }

  # Type: uint
  method total-results is rw  is g-property is also<total_results> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('total-results', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'total-results does not allow writing'
      }
    );
  }

  # Type: int64
  method updated ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('updated', $gv);
        my $u = $gv.int64;
        return $u if $raw;
        DateTime.new($u);
      },
      STORE => -> $, Int() $val is copy {
        warn 'updated does not allow writing'
      }
    );
  }

  method get_authors ( :$raw = False, :gslist(:$glist) = False )
    is also<get-authors>
  {
    returnGList(
      gdata_feed_get_authors($!gf),
      $raw,
      $glist,
      |GData::Author.getTypePair
    );
  }

  method get_categories ( :$raw = False, :gslist(:$glist) = False )
    is also<get-categories>
  {
    returnGList(
      gdata_feed_get_categories($!gf),
      $raw,
      $glist,
      |GData::Category.getTypePair
    );
  }

  method get_entries ( :$raw = False, :gslist(:$glist) = False )
    is also<get-entries>
  {
    returnGList(
      gdata_feed_get_entries($!gf),
      $raw,
      $glist,
      |GData::Entry.getTypePair
    );
  }

  method get_etag is also<get-etag> {
    gdata_feed_get_etag($!gf);
  }

  method get_generator ( :$raw = False ) is also<get-generator> {
    propReturnObject(
      gdata_feed_get_generator($!gf),
      $raw,
      |GData::Generator.getTypePair
    );
  }

  method get_icon is also<get-icon> {
    gdata_feed_get_icon($!gf);
  }

  method get_id is also<get-id> {
    gdata_feed_get_id($!gf);
  }

  method get_items_per_page is also<get-items-per-page> {
    gdata_feed_get_items_per_page($!gf);
  }

  method get_links ( :$raw = False, :gslist(:$glist) = False )
    is also<get-links>
  {
    returnGList(
      gdata_feed_get_links($!gf),
      $raw,
      $glist,
      |GData::Link.getTypePair
    );
  }

  method get_logo is also<get-logo> {
    gdata_feed_get_logo($!gf);
  }

  method get_next_page_token is also<get-next-page-token> {
    gdata_feed_get_next_page_token($!gf);
  }

  method get_rights is also<get-rights> {
    gdata_feed_get_rights($!gf);
  }

  method get_start_index is also<get-start-index> {
    gdata_feed_get_start_index($!gf);
  }

  method get_subtitle is also<get-subtitle> {
    gdata_feed_get_subtitle($!gf);
  }

  method get_title is also<get-title> {
    gdata_feed_get_title($!gf);
  }

  method get_total_results is also<get-total-results> {
    gdata_feed_get_total_results($!gf);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_feed_get_type, $n, $t );
  }

  method get_updated ( :$raw = False ) is also<get-updated> {
    my $u = gdata_feed_get_updated($!gf);
    return $u if $raw;
    DateTime.new($u);
  }

  method look_up_entry (Str() $id, :$raw = False) is also<look-up-entry> {
    propReturnObject(
      gdata_feed_look_up_entry($!gf, $id),
      $raw,
      |GData::Entry.getTypePair
    );
  }

  method look_up_link (Str() $rel, :$raw = False) is also<look-up-link> {
    propReturnObject(
      gdata_feed_look_up_link($!gf, $rel),
      $raw,
      |GData::Link.getTypePair
    );
  }

}
