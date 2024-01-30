use v6;

use GLib::Raw::Exports;
use GIO::Raw::Exports;
use JSON::GLib::Raw::Exports;
use GData::Raw::Exports;

unit package GData::Raw::Types;

need GLib::Raw::Debug;
need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Exceptions;
need GLib::Raw::Object;
need GLib::Raw::Structs;
need GLib::Raw::Subs;
need GLib::Raw::Struct_Subs;
need GLib::Roles::Pointers;
need GLib::Roles::Implementor;
need GIO::Raw::Definitions;
need GIO::Raw::Enums;
need GIO::Raw::Quarks;
need GIO::Raw::Structs;
need GIO::Raw::Subs;
need GIO::DBus::Raw::Types;
need JSON::GLib::Raw::Definitions;
need GData::Raw::Definitions;
need GData::Raw::Enums;
need GData::Raw::Structs;


BEGIN {
  glib-re-export($_) for |@glib-exports,
                         |@gio-exports,
                         |@jg-exports,
                         |@gdata-exports;
}
