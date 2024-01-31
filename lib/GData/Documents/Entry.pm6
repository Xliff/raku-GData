use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::Documents::Entry;

use GLib::GList;
use GData::Author;
# use GData::Documents::Property;
use GData::Entry;

use GLib::Roles::Implementor;

our subset GDataDocumentsEntryAncestry is export of Mu
  where GDataDocumentsEntry | GDataEntryAncestry;

class GData::Documents::Entry is GData::Entry {
  has GDataDocumentsEntry $!gde is implementor;

  submethod BUILD ( :$gdata-doc-entry ) {
    self.setGDataDocumentsEntry($gdata-doc-entry) if $gdata-doc-entry
  }

  method setGDataDocumentsEntry (GDataDocumentsEntryAncestry $_) {
    my $to-parent;

    $!gde = do {
      when GDataDocumentsEntry {
        $to-parent = cast(GDataEntry, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataDocumentsEntry, $_);
      }
    }
    self.setGDataEntry($to-parent);
  }

  method GData::Raw::Definitions::GDataDocumentsEntry
    is also<GDataDocumentsEntry>
  { $!gde }

  multi method new (
     $gdata-doc-entry where * ~~ GDataDocumentsEntryAncestry,
    :$ref                                                     = True
  ) {
    return unless $gdata-doc-entry;

    my $o = self.bless( :$gdata-doc-entry );
    $o.ref if $ref;
    $o;
  }

  # Type: boolean
  method can-edit is rw  is g-property is also<can_edit> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('can-edit', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'can-edit does not allow writing'
      }
    );
  }

  # Type: int64
  method file-size is rw  is g-property is also<file_size> {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('file-size', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        warn 'file-size does not allow writing'
      }
    );
  }

  # Type: boolean
  method is-deleted is rw  is g-property is also<is_deleted> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-deleted', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('is-deleted', $gv);
      }
    );
  }

  # Type: GDataAuthor
  method last-modified-by ( :$raw = False )
    is rw
    is g-property
    is also<last_modified_by>
  {
    my $gv = GLib::Value.new( GData::Author.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('last-modified-by', $gv);
        propReturnObject($gv.object, $raw, |GData::Author.getTypePair);
      },
      STORE => -> $,  $val is copy {
        warn 'last-modified-by does not allow writing'
      }
    );
  }

  # Type: int64
  method last-viewed ( :$raw = False )
    is rw
    is g-property
    is also<last_viewed>
  {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('last-viewed', $gv);
        my $l = $gv.int64;
        return $l unless $raw;
        DateTime.new($l);
      },
      STORE => -> $, Int() $val is copy {
        warn 'last-viewed does not allow writing'
      }
    );
  }

  # Type: int64
  method quota-used is rw  is g-property is also<quota_used> {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('quota-used', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        warn 'quota-used does not allow writing'
      }
    );
  }

  # Type: string
  method resource-id is rw  is g-property is also<resource_id> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('resource-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'resource-id does not allow writing'
      }
    );
  }

  # Type: int64
  method shared-with-me-date ( :$raw = False )
    is rw
    is g-property
    is also<shared_with_me_date>
  {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('shared-with-me-date', $gv);
        my $s = $gv.int64;
        return $s if $raw;
        DateTime.new($s);
      },
      STORE => -> $, Int() $val is copy {
        warn 'shared-with-me-date does not allow writing'
      }
    );
  }

  # Type: boolean
  method writers-can-invite is rw  is g-property is also<writers_can_invite> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('writers-can-invite', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('writers-can-invite', $gv);
      }
    );
  }

  method add_documents_property (GDataDocumentsProperty() $property)
    is also<add-documents-property>
  {
    gdata_documents_entry_add_documents_property($!gde, $property);
  }

  method get_can_edit is also<get-can-edit> {
    so gdata_documents_entry_can_edit($!gde);
  }

  method get_document_properties ( :$raw = False, :$glist = False )
    is also<get-document-properties>
  {
    returnGList(
      gdata_documents_entry_get_document_properties($!gde),
      $raw,
      $glist,
      |GData::Document::Property.getTypePair
    );
  }

  method get_file_size is also<get-file-size> {
    gdata_documents_entry_get_file_size($!gde);
  }

  method get_is_deleted is also<get-is-deleted> {
    so gdata_documents_entry_is_deleted($!gde);
  }

  method get_last_modified_by ( :$raw = False )
    is also<get-last-modified-by>
  {
    propReturnObject(
      gdata_documents_entry_get_last_modified_by($!gde),
      $raw,
      |GData::Author.getTypePair
    );
  }

  method get_last_viewed ( :$raw = False ) is also<get-last-viewed> {
    my $l = gdata_documents_entry_get_last_viewed($!gde);
    return $l if $raw;
    DateTime.new($l);
  }

  method get_path is also<get-path> {
    gdata_documents_entry_get_path($!gde);
  }

  method get_quota_used is also<get-quota-used> {
    gdata_documents_entry_get_quota_used($!gde);
  }

  method get_resource_id is also<get-resource-id> {
    gdata_documents_entry_get_resource_id($!gde);
  }

  method get_shared_with_me_date ( :$raw = False )
    is also<get-shared-with-me-date>
  {
    my $s = gdata_documents_entry_get_shared_with_me_date($!gde);
    return $s if $raw;
    DateTime.new($s);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(self.^name, &gdata_documents_entry_get_type, $n, $t );
  }

  method get_writers_can_invite is also<get-writers-can-invite> {
    so gdata_documents_entry_writers_can_invite($!gde);
  }

  method remove_documents_property (GDataDocumentsProperty() $property)
    is also<remove-documents-property>
  {
    gdata_documents_entry_remove_documents_property($!gde, $property);
  }

  method set_writers_can_invite (Int() $writers_can_invite)
    is also<set-writers-can-invite>
  {
    my gboolean $w = $writers_can_invite.so.Int;

    gdata_documents_entry_set_writers_can_invite($!gde, $w);
  }

}
