use v6.c;

use GData::Raw::Types;

use GIO::Application;
use GData::Youtube::Query;
use GData::Youtube::Service;

sub MAIN {
  my $a = GIO::Application.new('org.genex.gdata.youtube-query');

  $a.activate.tap: SUB {
    my $s = GData::Youtube::Service.new(
      'AIzaSyCQLeConee7miBuDg80FTMY3V9n1_62tS0'
    );

    my $q = GData::Youtube::Query.new;
    #( .max-results, .channel-id ) = (25, 'UC415bOPUcGSamy543abLmRA') given $q;
    $q.max-results = 25;

    print "\n";
    my $f = $s.query-videos($q);
    $f.json.say;
    $f.xml.say;
    for $f.entries.Array.sort( -*.published ).kv -> $k, $_ {
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
