package Acme::Net::IRC::Moosified::POE;

use strict;
use warnings;
use POE;
use vars qw($VERSION);

$VERSION = '0.02';

use MooseX::POE;
use Acme::Net::IRC::Moosified::POE::Connection;

has 'debug' => (
  is => 'rw',
  default => sub {0},
);

sub START {
  my ($kernel,$session) = @_[KERNEL,SESSION];
  $kernel->refcount_increment( $session->ID(), __PACKAGE__ );
  return;
}

sub newconn {
  my $self = shift;
  $self->call( '_newconn', @_ );
}

event '_newconn' => sub {
  my ($kernel,$self,@args) = @_[KERNEL,OBJECT,ARG0..$#_];
  return Acme::Net::IRC::Moosified::POE::Connection->new( $self, @args );
};

sub do_one_loop {
  $poe_kernel->run_one_timeslice();
}

sub start {
  $poe_kernel->run();
}

no MooseX::POE;

__PACKAGE__->meta->make_immutable;

'Moosey Moosey';

__END__
