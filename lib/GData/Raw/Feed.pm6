use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::Feed;

### /usr/src/libgdata/gdata/gdata-feed.h

sub gdata_feed_get_authors (GDataFeed $self)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_categories (GDataFeed $self)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_entries (GDataFeed $self)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_etag (GDataFeed $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_generator (GDataFeed $self)
  returns GDataGenerator
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_icon (GDataFeed $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_id (GDataFeed $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_items_per_page (GDataFeed $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_links (GDataFeed $self)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_logo (GDataFeed $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_next_page_token (GDataFeed $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_rights (GDataFeed $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_start_index (GDataFeed $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_subtitle (GDataFeed $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_title (GDataFeed $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_total_results (GDataFeed $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_get_updated (GDataFeed $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_look_up_entry (
  GDataFeed $self,
  Str       $id
)
  returns GDataEntry
  is      native(gdata)
  is      export
{ * }

sub gdata_feed_look_up_link (
  GDataFeed $self,
  Str       $rel
)
  returns GDataLink
  is      native(gdata)
  is      export
{ * }
