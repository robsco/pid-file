use strict;
use warnings;

use Test::More;
use Test::Exception;

use PID::File;

# basic checks

{
	my $pid_file = PID::File->new;
	
	dies_ok { $pid_file->remove } "dies ok trying to remove non-created file";
	
	dies_ok { $pid_file->guard } " dies okay trying to guard in void context";

	dies_ok { my $guard = $pid_file->guard } " dies okay trying to guard in scalar context";

	dies_ok { my @guard = $pid_file->guard } " dies okay trying to guard in list context";

	ok( $pid_file->create, "created pid file ok");

	lives_ok { $pid_file->remove; } "removed pid file ok";

	ok( ! -e $pid_file->file, "...and pid file ('" . $pid_file->file . "') does not exist");
	
}



done_testing();
