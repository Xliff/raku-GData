use v6.c;

unit package GData::Raw::Exports;

our @gdata-exports is export;

BEGIN {
  @gdata-exports = <
    GData::Raw::Definitions
    GData::Raw::Enums
    GData::Raw::Structs
  >;
}
