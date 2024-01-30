use v6.c;

use Method::Also;

use GData::Raw::Types;
use GData::Raw::Query;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GDataQueryAncestry is export of Mu
  where GDataQuery | GObject;

class GData::Query {
  also does GLib::Roles::Object;

  has GDataQuery $!gq is implementor;

  submethod BUILD ( :$gdata-query ) {
    self.setGDataQuery($gdata-query) if $gdata-query
  }

  method setGDataQuery (GDataQueryAncestry $_) {
    my $to-parent;

    $!gq = do {
      when GDataQuery {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataQuery, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GData::Raw::Definitions::GDataQuery
    is also<GDataQuery>
  { $!gq }

  multi method new ($gdata-query where * ~~ GDataQueryAncestry, :$ref = True) {
    return unless $gdata-query;

    my $o = self.bless( :$gdata-query );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $q = Str) {
    my $gdata-query = gdata_query_new($q);

    $gdata-query ?? self.bless( :$gdata-query ) !! Nil;
  }

  method new_with_limits (Str() $q, Int() $start_index, Int() $max_results)
    is also<new-with-limits>
  {
    my guint ($s, $m) = ($start_index, $max_results);

    my $gdata-query = gdata_query_new_with_limits($!gq, $q, $s, $m);

    $gdata-query ?? self.bless( :$gdata-query ) !! Nil;
  }

  # Type: string
  method author is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('author', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('author', $gv);
      }
    );
  }

  # Type: string
  method categories is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('categories', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('categories', $gv);
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

  # Type: boolean
  method is-strict is rw  is g-property is also<is_strict> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-strict', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('is-strict', $gv);
      }
    );
  }

  # Type: uint
  method max-results is rw  is g-property is also<max_results> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-results', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('max-results', $gv);
      }
    );
  }

  # Type: int64
  method published-max is rw  is g-property is also<published_max> {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('published-max', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int64 = $val;
        self.prop_set('published-max', $gv);
      }
    );
  }

  # Type: int64
  method published-min is rw  is g-property is also<published_min> {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('published-min', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int64 = $val;
        self.prop_set('published-min', $gv);
      }
    );
  }

  # Type: string
  method q is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('q', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('q', $gv);
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
        $gv.uint = $val;
        self.prop_set('start-index', $gv);
      }
    );
  }

  # Type: int64
  method updated-max is rw  is g-property is also<updated_max> {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('updated-max', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int64 = $val;
        self.prop_set('updated-max', $gv);
      }
    );
  }

  # Type: int64
  method updated-min is rw  is g-property is also<updated_min> {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('updated-min', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int64 = $val;
        self.prop_set('updated-min', $gv);
      }
    );
  }

  method get_author is also<get-author> {
    gdata_query_get_author($!gq);
  }

  method get_categories is also<get-categories> {
    gdata_query_get_categories($!gq);
  }

  method get_etag is also<get-etag> {
    gdata_query_get_etag($!gq);
  }

  method get_max_results is also<get-max-results> {
    gdata_query_get_max_results($!gq);
  }

  method get_published_max is also<get-published-max> {
    gdata_query_get_published_max($!gq);
  }

  method get_published_min is also<get-published-min> {
    gdata_query_get_published_min($!gq);
  }

  method get_q is also<get-q> {
    gdata_query_get_q($!gq);
  }

  method get_query_uri (Str() $feed_uri) is also<get-query-uri> {
    gdata_query_get_query_uri($!gq, $feed_uri);
  }

  method get_start_index is also<get-start-index> {
    gdata_query_get_start_index($!gq);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    usntable_get_type( self.^name, &gdata_query_get_type, $n, $t );
  }

  method get_updated_max is also<get-updated-max> {
    gdata_query_get_updated_max($!gq);
  }

  method get_updated_min is also<get-updated-min> {
    gdata_query_get_updated_min($!gq);
  }

  method is_strict is also<is-strict> {
    so gdata_query_is_strict($!gq);
  }

  method next_page is also<next-page> {
    gdata_query_next_page($!gq);
  }

  method previous_page is also<previous-page> {
    gdata_query_previous_page($!gq);
  }

  method set_author (Str() $author is copy) is also<set-author> {
    $author = Str if $author === Nil;

    gdata_query_set_author($!gq, $author);
  }

  method set_categories (Str() $categories is copy) is also<set-categories> {
    $categories = Str if $categories === Nil;

    gdata_query_set_categories($!gq, $categories);
  }

  method set_etag (Str() $etag is copy) is also<set-etag> {
    $etag = Str if $etag === Nil;

    gdata_query_set_etag($!gq, $etag);
  }

  method set_is_strict (Int() $is_strict) is also<set-is-strict> {
    my gboolean $i = $is_strict.so.Int;

    gdata_query_set_is_strict($!gq, $i);
  }

  method set_max_results (Int() $max_results) is also<set-max-results> {
    my guint $m = $max_results;

    gdata_query_set_max_results($!gq, $m);
  }

  method set_published_max (Int() $published_max) is also<set-published-max> {
    my gint64 $p = $published_max;

    gdata_query_set_published_max($!gq, $p);
  }

  method set_published_min (Int() $published_min) is also<set-published-min> {
    my gint64 $p = $published_min;

    gdata_query_set_published_min($!gq, $p);
  }

  method set_q (Str() $q is copy) is also<set-q> {
    $q = Str if $q === Nil;

    gdata_query_set_q($!gq, $q);
  }

  method set_start_index (Int() $start_index) is also<set-start-index> {
    my guint $s = $start_index;

    gdata_query_set_start_index($!gq, $s);
  }

  method set_updated_max (Int() $updated_max) is also<set-updated-max> {
    my gint64 $u = $updated_max;

    gdata_query_set_updated_max($!gq, $u);
  }

  method set_updated_min (Int() $updated_min) is also<set-updated-min> {
    my gint64 $u = $updated_min;

    gdata_query_set_updated_min($!gq, $u);
  }

}
