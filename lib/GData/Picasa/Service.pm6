use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use GData::Raw::Types;
use GData::Raw::Picasa::Service;

use GData::Authiorization::Domain;
use GData::Service;
# use GData::User;
use GData::Picasa::Album;
use GData::Picasa::Feed;

use GLib::Roles::Implementor;

our subset GDataPicasaWebServiceAncestry is export of Mu
  where GDataPicasaWebService | GDataServiceAncestry;

class GData::Picasa::Service is GData::Service {
  has GDataPicasaWebService $!gps is implementor;

  submethod BUILD ( :$gdata-pic-service ) {
    self.setGDataPicasaWebService($gdata-pic-service) if $gdata-pic-service
  }

  method setGDataPicasaWebService (GDataPicasaWebServiceAncestry $_) {
    my $to-parent;

    $!gps = do {
      when GDataPicasaWebService {
        $to-parent = cast(GDataService, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GDataPicasaWebService, $_);
      }
    }
    self.setGDataService($to-parent);
  }

  method GData::Raw::Definitions::GDataPicasaWebService
    is also<GDataPicasaWebService>
  { $!gps }

  multi method new (
     $gdata-pic-service where * ~~ GDataPicasaWebServiceAncestry,
    :$ref                                                         = True
  ) {
    return unless $gdata-pic-service;

    my $o = self.bless( :$gdata-pic-service );
    $o.ref if $ref;
    $o;
  }
  multi method new (GDataAuthorizer() $a) {
    my $gdata-pic-service = gdata_picasaweb_service_new($a);

    $gdata-pic-service ?? self.bless( :$gdata-pic-service ) !! Nil
  }

  method finish_file_upload (
    GDataUploadStream()      $upload_stream,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False
  )
    is also<finish-file-upload>
  {
    clear_error;
    my $f = gdata_picasaweb_service_finish_file_upload(
      $!gps,
      $upload_stream,
      $error
    );
    set_error($error);
    propReturnObject($f, $raw, |GData::Picasa::File.getTypePair)
  }

  method get_primary_authorization_domain ( :$raw = False )
    is also<get-primary-authorization-domain>
    is static
  {
    propReturnObject(
      gdata_picasaweb_service_get_primary_authorization_domain(),
      $raw,
      |GData::Authorization::Domain.getTypePair
    )
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdata_picasaweb_service_get_type, $n, $t );
  }

  method get_user (
    Str()                    $username,
    GCancellable()           $cancellable = GCancellable,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$raw         = False
  )
    is also<get-user>
  {
    clear_error;
    my $u = gdata_picasaweb_service_get_user(
      $!gps,
      $username,
      $cancellable,
      $error
    );
    set_error($error);
    propReturnObject($u, $raw, GData::Picasa::User.getTypePair)
  }

  proto method get_user_async (|)
    is also<get-user-async>
  { * }

  multi method get_user_async (
     $username,
     &callback,
     $user_data   = gpointer,
    :$cancellable = GCancellable
  ) {
    samewith(
      $username,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method get_user_async (
    Str()          $username,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    gdata_picasaweb_service_get_user_async(
      $!gps,
      $username,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method get_user_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False
  )
    is also<get-user-finish>
  {
    clear_error;
    my $u = gdata_picasaweb_service_get_user_finish($!gps, $result, $error);
    set_error($error);
    propReturnObject($u, $raw, |GData::Picasa::User.getTypePair);
  }

  method insert_album (
    GDataPicasaWebAlbum()    $album,
    GCancellable()           $cancellable,
    CArray[Pointer[GError]]  $error        = gerror,
                            :$raw          = False
  )
    is also<insert-album>
  {
    clear_error;
    my $a = gdata_picasaweb_service_insert_album(
      $!gps,
      $album,
      $cancellable,
      $error
    );
    set_error($error);
    propReturnObject($a, $raw, |GData::Picasa::Album.getTypePair);
  }

  proto method insert_album_async (|)
    is also<insert-album-async>
  { * }

  multi method insert_album_async (
     $album,
     &callback,
     $user_data   = gpointer,
    :$cancellable = GCancellable
  ) {
    samewith($album, $cancellable, &callback, $user_data);
  }
  multi method insert_album_async (
    GDataPicasaWebAlbum() $album,
    GCancellable()        $cancellable,
                          &callback,
    gpointer              $user_data     = gpointer
  ) {
    gdata_picasaweb_service_insert_album_async(
      $!gps,
      $album,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method query_all_albums (|)
    is also<query-all-albums>
  { * }

  multi method query_all_albums (
    :$error                                   = gerror,
    :progress-callback(:&progress_callback)   = Callable,
    :progress-user-data(:$progress_user_data) = gpointer,
    :user(:$username)                         = Str,
    :$cancellable                             = GCancellable,
    :$raw                                     = False
  ) {
    samewith(
       GDataQuery,
       $username,
       $cancellable,
       &progress_callback,
       $progress_user_data,
       $error,
      :$raw
    );
  }
  multi method query_all_albums (
     $query,
     $error                                   = gerror,
    :progress-callback(:&progress_callback)   = Callable,
    :progress-user-data(:$progress_user_data) = gpointer,
    :user(:$username)                         = Str,
    :$cancellable                             = GCancellable,
    :$raw                                     = False
  ) {
    samewith(
      $query,
      $username,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      $error,
      :$raw
    );
  }
  multi method query_all_albums (
    GDataQuery()             $query,
    Str()                    $username,
    GCancellable()           $cancellable,
                             &progress_callback,
    gpointer                 $progress_user_data = gpointer,
    CArray[Pointer[GError]]  $error              = gerror,
                            :$raw                = False
  ) {
    clear_error;
    my $f = gdata_picasaweb_service_query_all_albums(
      $!gps,
      $query,
      $username,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      $error
    );
    set_error($error);
    propReturnObject($f, $raw, |GData::Picasa::Feed.getTypePair);
  }

  my $GDN = %DEFAULT-CALLBACKS<GDestroyNotify>;

  multi method query_all_albums_async (
    GDataQuery   $query,
    Str          $username,
    GCancellable $cancellable,
                 &progress_callback,
    gpointer     $progress_user_data,
                 &destroy_progress_user_data,
                 &callback,
    gpointer     $user_data
  )
    is also<query-all-albums-async>
  {
    gdata_picasaweb_service_query_all_albums_async(
      $!gps,
      $query,
      $username,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      &destroy_progress_user_data,
      &callback,
      $user_data
    );
  }

  proto method query_files (|)
    is also<query-files>
  { * }

  multi method query_files (
    GDataPicasaWebAlbum()     $album,
    CArray[Pointer[GError]]   $error            = gerror,
    GDataQuery()             :$query            = GDataQuery,
    GCancellable()           :$cancellable      = GCancellable,
                             :progress-callback(:&progress_callback)
                                                = Callable,
    gpointer                 :progress-user-data(:$progress_user_data)
                                                = gpointer
  ) {
    samewith(
      $album,
      $query,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      $error
    );
  }
  multi method query_files (
    GDataPicasaWebAlbum()      $album,
    GDataQuery()               $query,
    GCancellable()             $cancellable        = GCancellable,
                               &progress_callback  = Callable,
    gpointer                   $progress_user_data = gpointer,
    CArray[Pointer[GError]]    $error              = gerror,
                              :$raw                = False
  ) {
    clear_error;
    my $f = gdata_picasaweb_service_query_files(
      $!gps,
      $album,
      $query,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      $error
    );
    propReturnObject($f, $raw, |GData::Picasa::Feed.getTypePair);
  }

  method query_files_async (
    GDataPicasaWebAlbum        $album,
    GDataQuery                 $query,
    GCancellable               $cancellable,
                               &progress_callback,
    gpointer                   $progress_user_data,
                               &destroy_progress_user_data,
                               &callback,
    gpointer                   $user_data
  )
    is also<query-files-async>
  {
    gdata_picasaweb_service_query_files_async(
      $!gps,
      $album,
      $query,
      $cancellable,
      &progress_callback,
      $progress_user_data,
      &destroy_progress_user_data,
      &callback,
      $user_data
    );
  }

  method upload_file (
    GDataPicasaWebAlbum     $album,
    GDataPicasaWebFile      $file_entry,
    Str                     $slug,
    Str                     $content_type,
    GCancellable            $cancellable,
    CArray[Pointer[GError]] $error
  )
    is also<upload-file>
  {
    gdata_picasaweb_service_upload_file(
      $!gps,
      $album,
      $file_entry,
      $slug,
      $content_type,
      $cancellable,
      $error
    );
  }

}
