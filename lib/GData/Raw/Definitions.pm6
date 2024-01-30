use v6.c;

use GLib::Raw::Definitions;

use GLib::Roles::Pointers;

unit package GData::Raw::Definitions;

constant gdata is export = 'gdata',v22;

class GDataAuthorizer     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GDataBufferChunk    is repr<CPointer> does GLib::Roles::Pointers is export { }
