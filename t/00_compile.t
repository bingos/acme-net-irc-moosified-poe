use strict;
use warnings;
use Test::More;

my @modules = qw(
	Acme::Net::IRC::Moosified::POE
	Acme::Net::IRC::Moosified::POE::Connection
	Acme::Net::IRC::Moosified::POE::Event
	Acme::Net::IRC::Moosified::POE::DCC
);

plan tests => scalar @modules;
use_ok($_) for @modules;

