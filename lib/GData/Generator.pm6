use v6.c;

use Method::Also;

use NativeCall;

use GData::Raw::Types;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GDataGeneratorAncestry is export of Mu
  where GDataGenerator | GObject;

class GData::Generator {
  also does GLib::Roles::Object;

  has GDataGenerator $!gg is implementor;

  submethod BUILD ( :$gdata-generator ) {
    self.setGDataGenerator($gdata-generator) if $gdata-generator
  }

  method setGDataGenerator (GDataGeneratorAncestry $_) {
    my $to-parent;

    $!gg = do {
      when GDataGenerator {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataGenerator, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GData::Raw::Definitions::GDataGenerator
    is also<GDataGenerator>
  { $!gg }

  multi method new (
     $gdata-generator where * ~~ GDataGeneratorAncestry,
    :$ref                                                = True
  ) {
    return unless $gdata-generator;

    my $o = self.bless( :$gdata-generator );
    $o.ref if $ref;
    $o;
  }
  multi method new (*%a) {
    my $gdata-generator = self.new-object-ptr(self.get_type);

    my $o = $gdata-generator ?? self.bless( :$gdata-generator ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Type: string
  method name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'name does not allow writing'
      }
    );
  }

  # Type: string
  method uri is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('uri', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'uri does not allow writing'
      }
    );
  }

  # Type: string
  method version is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('version', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'version does not allow writing'
      }
    );
  }

  method get_name is also<get-name> {
    gdata_generator_get_name($!gg);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(self.^name, &gdata_generator_get_type, $n, $t);
  }

  method get_uri is also<get-uri> {
    gdata_generator_get_uri($!gg);
  }

  method get_version is also<get-version> {
    gdata_generator_get_version($!gg);
  }
}

### /usr/src/libgdata/gdata/atom/gdata-generator.h

sub gdata_generator_get_name (GDataGenerator $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_generator_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_generator_get_uri (GDataGenerator $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_generator_get_version (GDataGenerator $self)
  returns Str
  is      native(gdata)
  is      export
{ * }
