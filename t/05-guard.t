use strict;
use warnings;

use Test::More;
use Test::Exception;

use PID::File;
use PID::File::Guard;

my $pid_file = PID::File->new;

my $guard;

dies_ok { PID::File::Guard->new( $pid_file, 'remove' ) } "new dies ok in void context";

lives_ok { $guard = PID::File::Guard->new( $pid_file, 'remove' ) } "lives ok in scalar context";

done_testing();
