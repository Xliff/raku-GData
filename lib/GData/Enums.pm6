use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Subs;
use GData::Raw::Definitions;

class GData::Enums::Youtube::Age {

  method get_type {
    state ($n, $t);

    sub gdata_youtube_age_get_type
      returns GType
      is      native(gdata)
    { * }

    unstable_get_type( self.^name, &gdata_youtube_age_get_type, $n, $t );
  }

}

class GData::Enums::Youtube::SafeSearch {

  method get_type {
    state ($n, $t);

    sub gdata_youtube_safe_search_get_type
      returns GType
      is      native(gdata)
    { * }

    unstable_get_type(
      self.^name,
      &gdata_youtube_safe_search_get_type,
      $n,
      $t
    );
  }

}

class GData::Enums::Media::Expression {

  method get_type {
    state ($n, $t);

    sub gdata_media_expression_get_type
      returns GType
      is      native(gdata)
    { * }

    unstable_get_type(
      self.^name,
      &gdata_media_expression_get_type,
      $n,
      $t
    );
  }

}

class GData::Enums::Media::Medium {

  method get_type {
    state ($n, $t);

    sub gdata_media_medium_get_type
      returns GType
      is      native(gdata)
    { * }

    unstable_get_type(
      self.^name,
      &gdata_media_medium_get_type,
      $n,
      $t
    );
  }

}
