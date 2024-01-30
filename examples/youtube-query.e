use v6.c;

use GData::Raw::Types;

use GIO::Application;
use GData::Youtube::Query;
use GData::Youtube::Service;

sub MAIN {
  my $a = GIO::Application.new('org.genex.gdata.youtube-query');

  $a.activate.tap: SUB {
    my $s = GData::Youtube::Service.new(
      'AIzaSyDNM-xfTw1XPa2W5xY-QWJR3mHS6TyidvE'
    );

    my $q = GData::Youtube::Query.new('beef wellington');
    #$q.author = 'Cleo Abrams';

    my $f = $s.query-videos($q);

    say "Response:\n{ $f.json }\n{ $f.xml }";

    my $gl = $f.entries;

    for $gl.Array.kv -> $k, $_ {
      say qq:to/VIDEO/;
        Result #{ $k.succ }:
          ID:        { .id }
          Title:     { .title }
          Summary:   { .summary }
          Published: { .published }
          URL:       { .url }
        VIDEO
    }

    $a.quit;
  }

  $a.run;
}
