use v6.c;

use Method::Also;

use GData::Raw::Types;
use GData::Raw::Entry;

# use GData::Author;
# use GData::Category;
# use GData::Link;
use GData::Parsable;

use GLib::Roles::Implementor;

our subset GDataEntryAncestry is export of Mu
  where GDataEntry | GDataParsableAncestry;

class GData::Entry is GData::Parsasble {
  has GDataEntry $!ge is implementor;

  submethod BUILD ( :$gdata-entry ) {
    self.setGDataEntry($gdata-entry) if $gdata-entry
  }

  method setGDataEntry (GDataEntryAncestry $_) {
    my $to-parent;

    $!ge = do {
      when GDataEntry {
        $to-parent = cast(GDataParsable, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataEntry, $_);
      }
    }
    self.setGDataParsable($to-parent);
  }

  method GData::Raw::Definitions::GDataEntry
    is also<GDataEntry>
  { $!ge }

  multi method new (
     $gdata-entry where * ~~ GDataEntryAncestry,
    :$ref                                        = True
  ) {
    return unless $gdata-entry;

    my $o = self.bless( :$gdata-entry );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gdata-entry = gdata_entry_new();

    $gdata-entry ?? self.bless( :$gdata-entry ) !! Nil;
  }

  # Type: string
  method content is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('content', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('content', $gv);
      }
    );
  }

  # Type: string
  method content-uri is rw  is g-property is also<content_uri> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('content-uri', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('content-uri', $gv);
      }
    );
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
        $gv.string = $val;
        self.prop_set('etag', $gv);
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
        $gv.string = $val;
        self.prop_set('id', $gv);
      }
    );
  }

  # Type: boolean
  method is-inserted is rw  is g-property is also<is_inserted> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-inserted', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'is-inserted does not allow writing'
      }
    );
  }

  # Type: int64
  method published is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('published', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        warn 'published does not allow writing'
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
        $gv.string = $val;
        self.prop_set('rights', $gv);
      }
    );
  }

  # Type: string
  method summary is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('summary', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('summary', $gv);
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
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  # Type: int64
  method updated is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('updated', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        warn 'updated does not allow writing'
      }
    );
  }

  method add_author (GDataAuthor() $author) is also<add-author> {
    gdata_entry_add_author($!ge, $author);
  }

  method add_category (GDataCategory() $category) is also<add-category> {
    gdata_entry_add_category($!ge, $category);
  }

  method add_link (GDataLink() $link) is also<add-link> {
    gdata_entry_add_link($!ge, $link);
  }

  method get_authors ( :$raw = False )
    is also<
      get-authors
      authors
    >
  {
    propReturnObject(
      gdata_entry_get_authors($!ge),
      $raw,
      |GData::Author.getTypePair
    )
  }

  method get_categories ( :$raw = False )
    is also<
      get-categories
      categories
    >
  {
    propReturnObject(
      gdata_entry_get_categories($!ge),
      $raw,
      |GData::Category.getTypePair
    );
  }

  method get_content is also<get-content> {
    gdata_entry_get_content($!ge);
  }

  method get_content_uri is also<get-content-uri> {
    gdata_entry_get_content_uri($!ge);
  }

  method get_etag is also<get-etag> {
    gdata_entry_get_etag($!ge);
  }

  method get_id is also<get-id> {
    gdata_entry_get_id($!ge);
  }

  method get_published is also<get-published> {
    gdata_entry_get_published($!ge);
  }

  method get_rights is also<get-rights> {
    gdata_entry_get_rights($!ge);
  }

  method get_summary is also<get-summary> {
    gdata_entry_get_summary($!ge);
  }

  method get_title is also<get-title> {
    gdata_entry_get_title($!ge);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_entry_get_type, $n, $t )
  }

  method get_updated is also<get-updated> {
    gdata_entry_get_updated($!ge);
  }

  method is_inserted is also<is-inserted> {
    so gdata_entry_is_inserted($!ge);
  }

  method look_up_link (Str() $rel, :$raw = False) is also<look-up-link> {
    propReturnObject(
      gdata_entry_look_up_link($!ge, $rel),
      $raw,
      |GData::Link.getTypePair
    );
  }

  method look_up_links (
    Str()  $rel,
          :$raw            = False,
          :gslist(:$glist) = False
  )
    is also<look-up-links>
  {
    returnGList(
      gdata_entry_look_up_links($!ge, $rel),
      $raw,
      $glist,
      |GData::Link.getTypePair
    )
  }

  method remove_link (GDataLink() $link) is also<remove-link> {
    gdata_entry_remove_link($!ge, $link);
  }

  method set_content (Str() $content) is also<set-content> {
    gdata_entry_set_content($!ge, $content);
  }

  method set_content_uri (Str() $content_uri) is also<set-content-uri> {
    gdata_entry_set_content_uri($!ge, $content_uri);
  }

  method set_rights (Str() $rights) is also<set-rights> {
    gdata_entry_set_rights($!ge, $rights);
  }

  method set_summary (Str() $summary) is also<set-summary> {
    gdata_entry_set_summary($!ge, $summary);
  }

  method set_title (Str() $title) is also<set-title> {
    gdata_entry_set_title($!ge, $title);
  }

}
