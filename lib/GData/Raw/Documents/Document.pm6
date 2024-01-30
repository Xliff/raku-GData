use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Structs;

unit package GData::Raw::Documents::Document;

### /usr/src/libgdata/gdata/services/documents/gdata-documents-document.h

sub gdata_documents_document_download (
  GDataDocumentsDocument  $self,
  GDataDocumentsService   $service,
  Str                     $export_format,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDataDownloadStream
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_document_get_download_uri (
  GDataDocumentsDocument $self,
  Str                    $export_format
)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_document_get_thumbnail_uri (GDataDocumentsDocument $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_document_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_documents_document_new (Str $id)
  returns GDataDocumentsDocument
  is      native(gdata)
  is      export
{ * }
