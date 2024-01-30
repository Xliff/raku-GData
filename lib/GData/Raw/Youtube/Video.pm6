use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GData::Raw::Definitions;
use GData::Raw::Enums;
use GData::Raw::Structs;

unit package GData::Raw::Youtube::Video;

### /usr/src/libgdata/gdata/services/youtube/gdata-youtube-video.h

sub gdata_youtube_video_get_access_control (
  GDataYouTubeVideo $self,
  Str               $action
)
  returns GDataYouTubePermission
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_aspect_ratio (GDataYouTubeVideo $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_category (GDataYouTubeVideo $self)
  returns GDataMediaCategory
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_coordinates (
  GDataYouTubeVideo $self,
  gdouble           $latitude is rw,
  gdouble           $longitude is rw
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_description (GDataYouTubeVideo $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_duration (GDataYouTubeVideo $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_favorite_count (GDataYouTubeVideo $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_keywords (GDataYouTubeVideo $self)
  returns CArray[Str]
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_location (GDataYouTubeVideo $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_media_rating (
  GDataYouTubeVideo $self,
  Str               $rating_type
)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_player_uri (GDataYouTubeVideo $self)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_rating (
  GDataYouTubeVideo $self,
  guint             $min is rw,
  guint             $max is rw,
  guint             $count is rw,
  gdouble           $average is rw
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_recorded (GDataYouTubeVideo $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_state (GDataYouTubeVideo $self)
  returns GDataYouTubeState
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_thumbnails (GDataYouTubeVideo $self)
  returns GList
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_type
  returns GType
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_uploaded (GDataYouTubeVideo $self)
  returns gint64
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_video_id_from_uri (Str $video_uri)
  returns Str
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_get_view_count (GDataYouTubeVideo $self)
  returns guint
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_is_private (GDataYouTubeVideo $self)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_is_restricted_in_country (
  GDataYouTubeVideo $self,
  Str               $country
)
  returns uint32
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_new (Str $id)
  returns GDataYouTubeVideo
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_set_access_control (
  GDataYouTubeVideo      $self,
  Str                    $action,
  GDataYouTubePermission $permission
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_set_aspect_ratio (
  GDataYouTubeVideo $self,
  Str               $aspect_ratio
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_set_category (
  GDataYouTubeVideo  $self,
  GDataMediaCategory $category
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_set_coordinates (
  GDataYouTubeVideo $self,
  gdouble           $latitude,
  gdouble           $longitude
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_set_description (
  GDataYouTubeVideo $self,
  Str               $description
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_set_is_private (
  GDataYouTubeVideo $self,
  gboolean          $is_private
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_set_keywords (
  GDataYouTubeVideo $self,
  CArray[Str]       $keywords
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_set_location (
  GDataYouTubeVideo $self,
  Str               $location
)
  is      native(gdata)
  is      export
{ * }

sub gdata_youtube_video_set_recorded (
  GDataYouTubeVideo $self,
  gint64            $recorded
)
  is      native(gdata)
  is      export
{ * }
