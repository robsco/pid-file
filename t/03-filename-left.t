use strict;
use warnings;

use Test::More;
use Test::Exception;

use PID::File;

my $pid_file = PID::File->new;

$pid_file->file( '/tmp/file-pid-named.pid' );

unlink $pid_file->file;

$pid_file->create;

ok( -e $pid_file->file, "pid file ('" . $pid_file->file . "') does exist");

ok( $pid_file->running, "pid file is running" );


done_testing();
