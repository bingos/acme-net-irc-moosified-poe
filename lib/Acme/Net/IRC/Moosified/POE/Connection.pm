package Acme::Net::IRC::Moosified::POE::Connection;

use strict;
use warnings;
use POE::Component::IRC;
use POE::Component::IRC::Common qw(:ALL);
use vars qw($VERSION);

$VERSION = '0.02';

use MooseX::POE;
use Moose::Util::TypeConstraints;

has 'nickname' => (
  is => 'ro',
  writer => 'set_nickname',
  default => sub { $ENV{IRCNICK} || eval { scalar getpwuid($>) } || $ENV{USER} || $ENV{LOGNAME} || 'WankerBot' },
  isa => subtype 'Str' => where { /^[A-Za-z_0-9`\-^\|\\\{}\[\]]+$/ },
);

has 'username' => (
  is => 'ro',
  default => sub { eval { scalar getpwuid($>) } || $ENV{USER} || $ENV{LOGNAME} || 'japh' },
  writer => 'set_username',
);

has 'ircname' => (
  is => 'ro',
  default => sub { $ENV{IRCNAME} || eval { (getpwuid($>))[6] } || 'Just Another Perl Hacker' },
  writer => 'set_ircname',
);

has 'parent' => (
  is => 'ro',
  isa => 'Acme::Net::IRC::Moosified::POE',
);

has 'port' => (
  is => 'ro',
  default => sub { 6667 },
  writer => 'set_port',
  isa => subtype 'Int' => where { $_ > 0 and $_ <= 65535 },
);

has 'hostname' => (
  is => 'ro',
  writer => 'set_hostname',
);

has 'server' => (
  is => 'ro',
  writer => 'set_server',
);

has 'ssl' => (
  is => 'ro',
  default => sub { 0 },
  writer => 'set_ssl',
);

sub BUILDARGS {
  my $class = shift;
  my $parent = shift;
  my %args = @_;
  $args{lc $_} = delete $args{$_} for keys %args;
  $args{parent} = $parent;
  return $class->SUPER::BUILDARGS(%args);
}

sub BUILD {
  my $self = shift;
  
}

# Prints a message to the defined error filehandle(s).
# No further description should be necessary.

sub printerr {
  shift;
  print STDERR @_, "\n";
}

# Prints a message to the defined output filehandle(s).
sub print {
  shift;
  print STDOUT @_, "\n";
}

no MooseX::POE;

'This is where the magic happens';

__END__

IRC commands:

admin
away
ctcp
ctcp_reply
info
invite
ison
join
kick
links
list
lusers
me
mode
motd
names
new_chat
new_get
new_send
nick
notice
oper
part
privmsg
quit
rehash
restart
sconnect
squit
stats
summon
timestamp
topic
trace
userhost
users
version
wallops
who
whois
whowas

new
AUTOLOAD
$meth
_add_generic_handler
add_global_handler
add_handler
add_default_handler
connect
connected
debug
dequote
DESTROY
disconnect
error
format
handler
ignore
maxlinelen
parse
parse_ctcp
parse_num
peer
printerr
print
schedule
schedule_output_event
server
sl
sl_real
unignore
_default
