use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::Query;

### /usr/src/libgdata/gdata/gdata-query.h

sub gdata_query_get_author (GDataQuery $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_query_get_categories (GDataQuery $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_query_get_etag (GDataQuery $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_query_get_max_results (GDataQuery $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_query_get_published_max (GDataQuery $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_query_get_published_min (GDataQuery $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_query_get_q (GDataQuery $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_query_get_query_uri (
  GDataQuery $self,
  Str        $feed_uri
)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_query_get_start_index (GDataQuery $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_query_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_query_get_updated_max (GDataQuery $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_query_get_updated_min (GDataQuery $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_query_is_strict (GDataQuery $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_query_new (Str $q)
  returns GDataQuery
  is      native(gdata)
  is      export
{ * }

sub gdata_query_new_with_limits (
  Str   $q,
  guint $start_index,
  guint $max_results
)
  returns GDataQuery
  is      native(gdata)
  is      export
{ * }

sub gdata_query_next_page (GDataQuery $self)
  is      native(gdata)
  is      export
{ * }

sub gdata_query_previous_page (GDataQuery $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_query_set_author (
  GDataQuery $self,
  Str        $author
)
  is      native(gdata)
  is      export
{ * }

sub gdata_query_set_categories (
  GDataQuery $self,
  Str        $categories
)
  is      native(gdata)
  is      export
{ * }

sub gdata_query_set_etag (
  GDataQuery $self,
  Str        $etag
)
  is      native(gdata)
  is      export
{ * }

sub gdata_query_set_is_strict (
  GDataQuery $self,
  gboolean   $is_strict
)
  is      native(gdata)
  is      export
{ * }

sub gdata_query_set_max_results (
  GDataQuery $self,
  guint      $max_results
)
  is      native(gdata)
  is      export
{ * }

sub gdata_query_set_published_max (
  GDataQuery $self,
  gint64     $published_max
)
  is      native(gdata)
  is      export
{ * }

sub gdata_query_set_published_min (
  GDataQuery $self,
  gint64     $published_min
)
  is      native(gdata)
  is      export
{ * }

sub gdata_query_set_q (
  GDataQuery $self,
  Str        $q
)
  is      native(gdata)
  is      export
{ * }

sub gdata_query_set_start_index (
  GDataQuery $self,
  guint      $start_index
)
  is      native(gdata)
  is      export
{ * }

sub gdata_query_set_updated_max (
  GDataQuery $self,
  gint64     $updated_max
)
  is      native(gdata)
  is      export
{ * }

sub gdata_query_set_updated_min (
  GDataQuery $self,
  gint64     $updated_min
)
  is      native(gdata)
  is      export
{ * }
