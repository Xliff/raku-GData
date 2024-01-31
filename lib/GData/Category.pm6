use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::Category;

use GData::Parsable;

our subset GDataCategoryAncestry is export of Mu
  where GDataCategory | GDataParsableAncestry;

class GData::Category is GData::Parsable {
  has GDataCategory $!gc is implementor;

  submethod BUILD ( :$gdata-cat ) {
    self.setGDataCategory($gdata-cat) if $gdata-cat
  }

  method setGDataCategory (GDataCategoryAncestry $_) {
    my $to-parent;

    $!gc = do {
      when GDataCategory {
        $to-parent = cast(GDataParsable, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataCategory, $_);
      }
    }
    self.setGDataParsable($to-parent);
  }

  method GData::Raw::Definitions::GDataCategory
    is also<GDataCategory>
  { $!gc }

  multi method new (
     $gdata-cat where * ~~ GDataCategoryAncestry,
    :$ref                                            = True
  ) {
    return unless $gdata-cat;

    my $o = self.bless( :$gdata-cat );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str() :$term    is required,
    Str() :$scheme               = Str,
    Str() :$label                = Str
  ) {
    samewith($term, $scheme, $label);
  }
  multi method new (
    Str() $term,
    Str() $scheme = Str,
    Str() $label  = Str
  ) {
    my $gdata-cat = gdata_category_new($term, $scheme, $label);

    $gdata-cat ?? self.bless( :$gdata-cat ) !! Nil;
  }

  # Type: string
  method label is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('label', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('label', $gv);
      }
    );
  }

  # Type: string
  method scheme is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scheme', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('scheme', $gv);
      }
    );
  }

  # Type: string
  method term is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('term', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('term', $gv);
      }
    );
  }

  method get_label is also<get-label> {
    gdata_category_get_label($!gc);
  }

  method get_scheme is also<get-scheme> {
    gdata_category_get_scheme($!gc);
  }

  method get_term is also<get-term> {
    gdata_category_get_term($!gc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_category_get_type, $n, $t );
  }

  method set_label (Str() $label) is also<set-label> {
    gdata_category_set_label($!gc, $label);
  }

  method set_scheme (Str() $scheme) is also<set-scheme> {
    gdata_category_set_scheme($!gc, $scheme);
  }

  method set_term (Str() $term) is also<set-term> {
    gdata_category_set_term($!gc, $term);
  }

}
