use strict;
use warnings;

use Test::More;
use Test::Exception;

use PID::File;

# basic checks

{
	my $pid_file = PID::File->new;
	
	lives_ok { $pid_file->remove( force => 1 ) } "lives ok removing by force";
	
	ok( ! -e $pid_file->file, "...and pid file ('" . $pid_file->file . "') does not exist");
}

my $file;

{
	my $pid_file = PID::File->new;
	
	$pid_file->create;
	
	my $guard;
		
	lives_ok { $guard = $pid_file->guard( force => 1 ) } " lives okay forcing guard in scalar context";

	$file = $pid_file->file;
	
}

ok( ! -e $file, "...and pid file ('" . $file . "') got removed ok");



done_testing();
