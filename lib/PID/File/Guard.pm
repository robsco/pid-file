package PID::File::Guard;

use 5.006;

use strict;
use warnings;

=head1 NAME

PID::File::Guard - Provides scope guard to remove the pid file automatically.

=cut

=head1 Methods

=head2 Class Methods

=head3 new

 my $guard = PID::File::Guard->new( $object, 'method' );

Creates a new guard token that will call the C<method> on the C<object> when it goes out of scope. 

=cut

sub new
{
	my ( $class, $sub ) = @_;
	die "Can't create guard in void context" if ! defined wantarray;
	return bless $sub, $class;
}

sub DESTROY
{
	my $self = shift;

	$self->();
}


1;

