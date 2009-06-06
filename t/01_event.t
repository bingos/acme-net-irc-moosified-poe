use strict;
use warnings;
use Test::More tests => 11;

use Acme::Net::IRC::Moosified::POE::Event;

my $event = Acme::Net::IRC::Moosified::POE::Event->new(
  'privmsg',
  'bingos!bucket@moocow.com',
  '#IRC.pm',
  'privmsg',
  'Hi!',
);

isa_ok($event,'Acme::Net::IRC::Moosified::POE::Event');

is($event->type,'privmsg','Type');
is($event->from,'bingos!bucket@moocow.com','From');
is($event->nick,'bingos','Nick');
is($event->user,'bucket','User');
is($event->host,'moocow.com','Host');
is($event->userhost,'bucket@moocow.com','Userhost');
is(ref $event->to, 'ARRAY','To is array');
is($event->to->[0],'#IRC.pm','To');
is(ref $event->args,'ARRAY','Args is array');
is($event->args->[0],'Hi!','Args');
