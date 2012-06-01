use strict;
use warnings;

use Test::More;
use Test::Exception;

use PID::File;

my $pid_file = PID::File->new;

$pid_file->file( '/tmp/file-pid-named.pid' );

ok( -e $pid_file->file, "old pid file ('" . $pid_file->file . "') still exists");

ok( ! $pid_file->running, "pid file is not running" );

ok( $pid_file->create, "created new pid file ok" );

ok( -e $pid_file->file, "new pid file ('" . $pid_file->file . "') does exist");

ok( $pid_file->running, "new pid file is running" );

lives_ok { $pid_file->remove; } "removed pid file ok";

ok( ! -e $pid_file->file, "pid file ('" . $pid_file->file . "') does not exist");

ok( ! $pid_file->running, "pid file is not running" );



done_testing();
