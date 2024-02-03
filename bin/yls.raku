use v6;

use Cro::HTTP::Client;
use Terminal::UI 'ui';

use GData::Youtube::Query;
use GData::Youtube::Service;

sub reset-ui {
  ui.shutdown;
  print "\n";
}

sub MAIN (
       $channel is copy,           #= Channel name or id (names must start with '@')
  Int :$num     where * <= 50 = 25 #= Number of results per page (max 50)
) {
  END reset-ui;

  if $channel.starts-with('@') {
    my $url = "http://youtube.com/{ $channel }";

    my ($r, $b);
    try {
      CATCH {
        default {
          say "ERROR: { .message }";
          exit;
        }
      }

      $r = await Cro::HTTP::Client.get($url);
      $b = await $r.body;
    }

    if $b ~~ / 'www.youtube.com/channel/' ( <-[\"]>+ )  / -> $m {
      $channel = $m[0].Str;
    } else {
      say "Sorry! Could not find a channel ID from { $url }!";
      exit;
    }
  }

  say $/.Str;

  my $s = GData::Youtube::Service.new(
    'AIzaSyDNM-xfTw1XPa2W5xY-QWJR3mHS6TyidvE'
  );

  my $q = GData::Youtube::Query.new;
  ( .max-results, .channel-id ) = (25, $channel) given $q;

  my $continue;
  repeat {
    $continue = False;
    my $f = $s.query-videos($q);
    say "JSON: { $f.json }";
    say "XML: { $f.xml }";
    my @r = $f.entries.Array.sort( -*.published );
    for @r {
      say "{ .title.substr(0, 40).fmt('%-40s') }\t{ .published }\t{ .url }"
    }
    last unless @r == $num;
    print "Press Q to quit or any other key for the next page";
    $continue = True unless ui.get-key.lc eq 'q';
    if $continue {
      $q.next-page;
      reset-ui;
      $q.start-index.say;
    }
  } until $continue.not;
  print "\n";
}
