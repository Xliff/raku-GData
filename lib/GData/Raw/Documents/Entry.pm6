use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::Documents::Entry;

### /usr/src/libgdata/gdata/services/documents/gdata-documents-entry.h

sub gdata_documents_entry_add_documents_property (
  GDataDocumentsEntry    $self,
  GDataDocumentsProperty $property
)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_entry_can_edit (GDataDocumentsEntry $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_entry_get_document_properties (GDataDocumentsEntry $self)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_entry_get_file_size (GDataDocumentsEntry $self)
  returns goffset
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_entry_get_last_modified_by (GDataDocumentsEntry $self)
  returns GDataAuthor
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_entry_get_last_viewed (GDataDocumentsEntry $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_entry_get_path (GDataDocumentsEntry $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_entry_get_quota_used (GDataDocumentsEntry $self)
  returns goffset
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_entry_get_resource_id (GDataDocumentsEntry $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_entry_get_shared_with_me_date (GDataDocumentsEntry $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_entry_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_entry_is_deleted (GDataDocumentsEntry $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_entry_remove_documents_property (
  GDataDocumentsEntry    $self,
  GDataDocumentsProperty $property
)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_entry_set_writers_can_invite (
  GDataDocumentsEntry $self,
  gboolean            $writers_can_invite
)
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_entry_writers_can_invite (GDataDocumentsEntry $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }
