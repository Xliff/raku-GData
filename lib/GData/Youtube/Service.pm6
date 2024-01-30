use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::Youtube::Service;

# use GData::Authorization::Domain;
use GData::Service;
use GData::Youtube::Feed;
use GData::Youtube::Video;

use GLib::Roles::Implementor;

our subset GDataYoutubeServiceAncestry is export of Mu
  where GDataYoutubeService | GDataServiceAncestry;

class GData::Youtube::Service is GData::Service {
  has GDataYoutubeService $!gys is implementor;

  submethod BUILD ( :$gdata-yousvc ) {
    self.setGDataYoutubeService($gdata-yousvc) if $gdata-yousvc
  }

  method setGDataYoutubeService (GDataYoutubeServiceAncestry $_) {
    my $to-parent;

    $!gys = do {
      when GDataYoutubeService {
        $to-parent = cast(GDataService, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataYoutubeService, $_);
      }
    }
    self.setGDataService($to-parent);
  }

  method GData::Raw::Definitions::GDataYoutubeService
    is also<GDataYoutubeService>
  { $!gys }

  multi method new (
     $gdata-yousvc where * ~~ GDataYoutubeServiceAncestry,
    :$ref                                                  = True
  ) {
    return unless $gdata-yousvc;

    my $o = self.bless( :$gdata-yousvc );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str()             $developer-key,
    GDataAuthorizer() $authorizer     = GDataAuthorizer
  ) {
    my $gdata-yousvc = gdata_youtube_service_new($developer-key, $authorizer);

    $gdata-yousvc ?? self.bless( :$gdata-yousvc ) !! Nil
  }

  # Type: string
  method developer-key is rw  is g-property is also<developer_key> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('developer-key', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('developer-key', $gv);
      }
    );
  }

  method error_quark is static is also<error-quark> {
    gdata_youtube_service_error_quark($!gys);
  }

  method finish_video_upload (
    GDataUploadStream()      $upload_stream,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False
  )
    is also<finish-video-upload>
  {
    clear_error;
    my $v = gdata_youtube_service_finish_video_upload(
      $!gys,
      $upload_stream,
      $error
    );
    set_error($error);
    propReturnObject($v, $raw, |GData::Youtube::Video.getTypePair)
  }

  method get_categories (
    GCancellable            $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<get-categories>
  {
    gdata_youtube_service_get_categories($!gys, $cancellable, $error);
  }

  proto method get_categories_async (|)
    is also<get-categories-async>

  multi method get_categories_async (
     &callback,
     $user_data   = gpointer,
    :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method get_categories_async (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data = gpointer
  ) {
    gdata_youtube_service_get_categories_async(
      $!gys,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method get_categories_finish (
    GAsyncResult()          $async_result,
    CArray[Pointer[GError]] $error         = gerror
  )
    is also<get-categories-finish>
  {
    gdata_youtube_service_get_categories_finish($!gys, $async_result, $error);
  }

  method get_developer_key is also<get-developer-key> {
    gdata_youtube_service_get_developer_key($!gys);
  }

  method get_primary_authorization_domain ( :$raw = False ) is also<get-primary-authorization-domain> {
    propReturnObject(
      gdata_youtube_service_get_primary_authorization_domain($!gys),
      $raw,
      |GData::Authorization::Domain.getTypePair
    )
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_youtube_service_get_type, $n, $t );
  }

  proto method query_related (|)
    is also<query-related>
  { * }

  multi method query_related (
     $video,
     $error                                   = gerror
    :$cancellable                             = GCancellable,
    :progress-callback(:&progress_callback)   = Callable,
    :progress-user-data(:$progress_user_data) = gpointer,
    :$raw                                     = False
  ) {
    samewith(
       $video,
       GDataQuery,
       $cancellable,
       &progress_callback,
       $progress_user_data,
       $error,
      :$raw
    )
  }
  multi method query_related (
     $video,
     $query,
     $error                                   = gerror,
    :$cancellable                             = GCancellable,
    :progress-callback(:&progress_callback)   = Callable,
    :progress-user-data(:$progress_user_data) = gpointer,
    :$raw                                     = False
  ) {
    samewith(
       $video,
       $query,
       $cancellable,
       &progress_callback,
       $progress_user_data,
       $error,
      :$raw
    );
  }
  multi method query_related (
    GDataYouTubeVideo()        $video,
    GDataQuery()               $query,
    GCancellable()             $cancellable,
                               &progress_callback,
    gpointer                   $progress_user_data = gpointer,
    CArray[Pointer[GError]]    $error              = gerror,
                              :$raw                = False
  ) {
    clear_error;
    my $f = gdata_youtube_service_query_related(
      $!gys,
      $video,
      $query,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      $error
    );
    set_error($error);
    propReturnObject($f, $raw, |GData::Youtube::Feed.getTypePair);
  }

  proto method query_related_async (|)
    is also<query-related-async>
  { * }

  multi method query_related_async (
     $video,
     &callback,
     $user_data                    = gpointer
    :$cancellable                  = GCancellable,
    :&progress_callback            = Callable,
    :$progress_user_data           = gpoiner,
    :&destroy_progress_user_data   = %DEFAULT-CALLBACKS<GDestroyNotify>,
  ) {
    samewith(
      $video,
      GDataQuery,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      &destroy_progress_user_data,
      &callback,
      $user_data
    );
  }
  multi method query_related_async (
     $video,
     &callback,
     $user_data                    = gpointer
    :$cancellable                  = GCancellable,
    :&progress_callback            = Callable,
    :$progress_user_data           = gpoiner,
    :&destroy_progress_user_data   = %DEFAULT-CALLBACKS<GDestroyNotify>,
  ) {
    samewith(
      $video,
      $query,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      &destroy_progress_user_data,
      &callback,
      $user_data
    );
  }
  multi method query_related_async (
    GDataYouTubeVideo() $video,
    GDataQuery()        $query,
    GCancellable()      $cancellable,
                        &progress_callback,
    gpointer            $progress_user_data,
                        &destroy_progress_user_data,
                        &callback,
    gpointer            $user_data                    = gpointer
  ) {
    gdata_youtube_service_query_related_async(
      $!gys,
      $video,
      $query,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      &destroy_progress_user_data,
      &callback,
      $user_data
    );
  }

  proto method query_standard_feed (|)
    is also<query-standard-feed>
  { * }

  multi method query_standard_feed (
     $feed_type,
     $error,
    :$cancellable        = GCancellable,
    :&progress_callback  = Callable,
    :$progress_user_data = gpointer,
    :$raw                = False
  ) {
    samewith(
       $feed_type,
       GDataQuery,
       $cancellable,
       &progress_callback,
       $progress_user_data,
       $error,
      :$raw
    );
  }
  multi method query_standard_feed (
     $feed_type,
     $query,
     $error,
    :$cancellable        = GCancellable,
    :&progress_callback  = Callable,
    :$progress_user_data = gpointer,
    :$raw                = False
  ) {
    samewith(
       $feed_type,
       $query,
       $cancellable,
       &progress_callback,
       $progress_user_data,
       $error,
      :$raw
    );
  }
  multi method query_standard_feed (
    Int()                    $feed_type,
    GDataQuery               $query,
    GCancellable             $cancellable,
                             &progress_callback,
    gpointer                 $progress_user_data  = gpointer,
    CArray[Pointer[GError]]  $error               = gerror,
                            :$raw                 = False
  ) {
    my GDataYouTubeStandardFeedType $f = $feed_type;

    clear_error;
    my $f = gdata_youtube_service_query_standard_feed(
      $!gys,
      $f,
      $query,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      $error
    );
    set_error($error);
    propReturnObject($f, $raw, |GData::Youtube::Feed.getTypePair)
  }

  method query_standard_feed_async (
    GDataYouTubeStandardFeedType $feed_type,
    GDataQuery                   $query,
    GCancellable                 $cancellable,
    GDataQueryProgressCallback   $progress_callback,
    gpointer                     $progress_user_data,
    GDestroyNotify               $destroy_progress_user_data,
    GAsyncReadyCallback          $callback,
    gpointer                     $user_data
  )
    is also<query-standard-feed-async>
  {
    gdata_youtube_service_query_standard_feed_async($!gys, $feed_type, $query, $cancellable, $progress_callback, $progress_user_data, $destroy_progress_user_data, $callback, $user_data);
  }

  proto method query_videos (|)
    is also<query-videos>
  { * }

  multi method query_videos (
     $error              = gerror,
    :$cancellable        = GCancellable,
    :&progress_callback  = Callable,
    :$progress_user_data = gpointer,
    :$raw                = False
  ) {
    samewith(
       GDataQuery,
       $cancellable,
       &progress_callback,
       $progress_user_data,
       $error,
      :$raw
    );
  }
  multi method query_videos (
     $query,
     $error              = gerror,
    :$cancellable        = GCancellable,
    :&progress_callback  = Callable,
    :$progress_user_data = gpointer,
    :$raw                = False
  ) {
    samewith(
       $query,
       $cancellable,
       &progress_callback,
       $progress_user_data,
       $error,
      :$raw
    );
  }
  multi method query_videos (
    GDataQuery()             $query,
    GCancellable()           $cancellable,
                             &progress_callback,
    gpointer                 $progress_user_data = gpointer,
    CArray[Pointer[GError]]  $error              = gerror,
                            :$raw = False
  ) {
    clear_error;
    my $f = gdata_youtube_service_query_videos(
      $!gys,
      $query,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      $error
    );
    set_error($error);
    propReturnObject($f, $raw, |GData::Youtube::Feed.getTypePair)
  }

  method query_videos_async (
    GDataQuery                 $query,
    GCancellable               $cancellable,
    GDataQueryProgressCallback $progress_callback,
    gpointer                   $progress_user_data,
    GDestroyNotify             $destroy_progress_user_data,
    GAsyncReadyCallback        $callback,
    gpointer                   $user_data
  )
    is also<query-videos-async>
  {
    gdata_youtube_service_query_videos_async($!gys, $query, $cancellable, $progress_callback, $progress_user_data, $destroy_progress_user_data, $callback, $user_data);
  }

  method upload_video (
    GDataYouTubeVideo()     $video,
    Str()                   $slug,
    Str()                   $content_type,
    GCancellable()          $cancellable   = GCancellable,
    CArray[Pointer[GError]] $error         = gerror
  )
    is also<upload-video>
  {
    gdata_youtube_service_upload_video(
      $!gys,
      $video,
      $slug,
      $content_type,
      $cancellable,
      $error
    );
  }

}
