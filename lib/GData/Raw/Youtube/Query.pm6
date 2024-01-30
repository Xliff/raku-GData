use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GData::Raw::Definitions;
use GData::Raw::Enums;
use GData::Raw::Structs;

unit package GData::Raw::Youtube::Query;

### /usr/src/libgdata/gdata/services/youtube/gdata-youtube-query.h

sub gdata_youtube_query_get_age (GDataYouTubeQuery $self)
  returns GDataYouTubeAge
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_query_get_license (GDataYouTubeQuery $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_query_get_channel_id (GDataYouTubeQuery $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_query_get_location (
  GDataYouTubeQuery $self,
  gdouble           $latitude  is rw,
  gdouble           $longitude is rw,
  gdouble           $radius    is rw
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_query_get_order_by (GDataYouTubeQuery $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_query_get_restriction (GDataYouTubeQuery $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_query_get_safe_search (GDataYouTubeQuery $self)
  returns GDataYouTubeSafeSearch
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_query_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_query_new (Str $q)
  returns GDataYouTubeQuery
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_query_set_age (
  GDataYouTubeQuery $self,
  GDataYouTubeAge   $age
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_query_set_channel_id (
  GDataYouTubeQuery $self,
  Str               $channel-id
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_query_set_license (
  GDataYouTubeQuery $self,
  Str               $license
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_query_set_location (
  GDataYouTubeQuery $self,
  gdouble           $latitude,
  gdouble           $longitude,
  gdouble           $radius
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_query_set_order_by (
  GDataYouTubeQuery $self,
  Str               $order_by
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_query_set_restriction (
  GDataYouTubeQuery $self,
  Str               $restriction
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_query_set_safe_search (
  GDataYouTubeQuery      $self,
  GDataYouTubeSafeSearch $safe_search
)
  is      native(gdata)
  is      export
{ * }
