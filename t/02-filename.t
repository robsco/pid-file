use strict;
use warnings;

use Test::More;
use Test::Exception;

use PID::File;

my $pid_file = PID::File->new;

lives_ok { $pid_file->file( '/tmp/file-pid-named.pid' ) } "set filename manually";

unlink $pid_file->file;

ok( ! $pid_file->running, "pid file is not running" );

ok( ! -e $pid_file->file, "pid file ('" . $pid_file->file . "') does not exist");

lives_ok { $pid_file->create; } "created pid file ok";

ok( -e $pid_file->file, "pid file ('" . $pid_file->file . "') does exist");

ok( $pid_file->running, "pid file is running" );

lives_ok { $pid_file->remove; } "removed pid file ok";

ok( ! -e $pid_file->file, "pid file ('" . $pid_file->file . "') does not exist");

ok( ! $pid_file->running, "pid file is not running" );

done_testing();
