use v6.c;

use NativeCall;
use Method::Also;

use GData::Raw::Types;
use GData::Raw::Documents::Document;

use GData::DownloadStream;

use GData::Documents::Entry;

use GLib::Roles::Implementor;

our subset GDataDocumentsDocumentAncestry is export of Mu
  where GDataDocumentsDocument | GDataDocumentsEntryAncestry;

class GData::Documents::Document is GData::Documents::Entry {
  has GDataDocumentsDocument $!gdd is implementor;

  submethod BUILD ( :$gdata-doc-doc ) {
    self.setGDataDocumentsDocument($gdata-doc-doc) if $gdata-doc-doc
  }

  method setGDataDocumentsDocument (GDataDocumentsDocumentAncestry $_) {
    my $to-parent;

    $!gdd = do {
      when GDataDocumentsDocument {
        $to-parent = cast(GDataDocumentsEntry, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataDocumentsDocument, $_);
      }
    }
    self.setGDataDocumentsEntry($to-parent);
  }

  method GData::Raw::Definitions::GDataDocumentsDocument
    is also<GDataDocumentsDocument>
  { $!gdd }

  multi method new (
     $gdata-doc-doc where * ~~ GDataDocumentsDocumentAncestry,
    :$ref                                                      = True
  ) {
    return unless $gdata-doc-doc;

    my $o = self.bless( :$gdata-doc-doc );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $id) {
    my $gdata-doc-doc = gdata_documents_document_new($id);

    $gdata-doc-doc ?? self.bless( :$gdata-doc-doc ) !! Nil;
  }

  method download (
    GDataDocumentsService()  $service,
    Str()                    $export_format,
    GCancellable()           $cancellable    = GCancellable,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False
  ) {
    clear_error;
    my $d = gdata_documents_document_download(
      $!gdd,
      $service,
      $export_format,
      $cancellable,
      $error
    );
    set_error($error);
    propReturnObject($d, $raw, |GData::DownloadStream.getTypePair);
  }

  method get_download_uri (Str() $export_format) is also<get-download-uri> {
    gdata_documents_document_get_download_uri($!gdd, $export_format);
  }

  method get_thumbnail_uri is also<get-thumbnail-uri> {
    gdata_documents_document_get_thumbnail_uri($!gdd);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gdata_documents_document_get_type,
      $n,
      $t
    );
  }

}
