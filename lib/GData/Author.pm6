use v6.c;

use Method::Also;

use GData::Raw::Types;
use GData::Raw::Author;

use GData::Parsable;

use GLib::Roles::Implementor;
use GLib::Roles::Object;


our subset GDataAuthorAncestry is export of Mu
  where GDataAuthor | GDataParsableAncestry;

class GData::Author is GData::Parsable {
  has GDataAuthor $!ga is implementor;

  submethod BUILD ( :$gdata-author ) {
    self.setGDataAuthor($gdata-author) if $gdata-author
  }

  method setGDataAuthor (GDataAuthorAncestry $_) {
    my $to-parent;

    $!ga = do {
      when GDataAuthor {
        $to-parent = cast(GDataParsable, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataAuthor, $_);
      }
    }
    self.setGDataParsable($to-parent);
  }

  method GData::Raw::Structs::GDataAuthor
    is also<GDataAuthor>
  { $!ga }

  multi method new (
     $gdata-author where * ~~ GDataAuthorAncestry,
    :$ref                                          = True
  ) {
    return unless $gdata-author;

    my $o = self.bless( :$gdata-author );
    $o.ref if $ref;
    $o;
  }

  proto method new (|)
  { * }

  multi method new (
    Str() :$name is required,
    Str() :$uri               = Str,
    Str() :$email-address     = Str
  ) {
    samewith($name, $uri, $email-address);
  }
  multi method new (
    Str() $name,
    Str() $uri           = Str,
    Str() $email_address = Str
  ) {
    my $gdata-author = gdata_author_new($name, $uri, $email_address);

    $gdata-author ?? self.bless( :$gdata-author ) !! Nil;
  }

  # Type: string
  method email-address is rw  is g-property is also<email_address> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('email-address', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('email-address', $gv);
      }
    );
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
        $gv.string = $val;
        self.prop_set('name', $gv);
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
        $gv.string = $val;
        self.prop_set('uri', $gv);
      }
    );
  }

  method get_email_address is also<get-email-address> {
    gdata_author_get_email_address($!ga);
  }

  method get_name is also<get-name> {
    gdata_author_get_name($!ga);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_author_get_type, $n, $t );
  }

  method get_uri is also<get-uri> {
    gdata_author_get_uri($!ga);
  }

  method set_email_address (Str() $email_address) is also<set-email-address> {
    gdata_author_set_email_address($!ga, $email_address);
  }

  method set_name (Str() $name) is also<set-name> {
    gdata_author_set_name($!ga, $name);
  }

  method set_uri (Str() $uri) is also<set-uri> {
    gdata_author_set_uri($!ga, $uri);
  }

}
