use strict;
use warnings;

use Test::More;
use Test::Exception;

use PID::File;

my $file;

{
	my $pid_file = PID::File->new;
	
	dies_ok { $pid_file->guard } "new dies ok in void context";

	my $guard = $pid_file->guard;

	ok( $pid_file->create, "created pid file ok");
	
	$file = $pid_file->file;
		
	ok( -e $pid_file->file, "pid file ('" . $pid_file->file . "') does exist");
}

ok( ! -e $file, "guard went out of scope and pid file ('" . $file . "') does not exist");

done_testing();
