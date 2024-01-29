use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::Entry;

### /usr/src/libgdata/gdata/gdata-entry.h

sub gdata_entry_add_author (
  GDataEntry  $self,
  GDataAuthor $author
)
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_add_category (
  GDataEntry    $self,
  GDataCategory $category
)
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_add_link (
  GDataEntry $self,
  GDataLink  $link
)
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_get_authors (GDataEntry $self)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_get_categories (GDataEntry $self)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_get_content (GDataEntry $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_get_content_uri (GDataEntry $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_get_etag (GDataEntry $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_get_id (GDataEntry $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_get_published (GDataEntry $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_get_rights (GDataEntry $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_get_summary (GDataEntry $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_get_title (GDataEntry $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_get_updated (GDataEntry $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_is_inserted (GDataEntry $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_look_up_link (
  GDataEntry $self,
  Str        $rel
)
  returns GDataLink
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_look_up_links (
  GDataEntry $self,
  Str        $rel
)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_new (Str $id)
  returns GDataEntry
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_remove_link (
  GDataEntry $self,
  GDataLink  $_link
)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_set_content (
  GDataEntry $self,
  Str        $content
)
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_set_content_uri (
  GDataEntry $self,
  Str        $content_uri
)
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_set_rights (
  GDataEntry $self,
  Str        $rights
)
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_set_summary (
  GDataEntry $self,
  Str        $summary
)
  is      native(gdata)
  is      export
{ * }

sub gdata_entry_set_title (
  GDataEntry $self,
  Str        $title
)
  is      native(gdata)
  is      export
{ * }
