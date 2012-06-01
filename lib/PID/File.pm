package PID::File;

use 5.006;

use strict;
use warnings;

use File::Basename qw(fileparse);
use FindBin qw($Bin);

=head1 NAME

PID::File - PID files, that just work.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';
$VERSION = eval $VERSION;

=head1 SYNOPSIS

Create PID files.

 use PID::File;
 
 my $pid_file = PID::File->new;
 
 if ( $pid_file->running )
 {
     exit;
 }
 else
 {
     $pid_file->create;
 }
 
 # do some stuff
 
 $pid_file->remove;
 
=head1 DESCRIPTION

Creating a pid file, or lock file, should be such a simple process, unfortunately other modules on CPAN have bugs and are not being maintained.

See L<Daemon::Control> for a more complete solution for creating daemons (and pid files) - the code for this module was largely borrowed from there.

=head1 Methods

=head2 Class Methods

=head3 new

=cut

sub new
{
	my ( $class, %args ) = @_;
	
	my $self = { file => $args{ file },
	           };
	
	bless( $self, $class );
	
	return $self;
}


=head2 Instance Methods

=head3 file

The filename for the pid file.

Can be relative to the directory where your scripts runs, or absolute.

By default it will use the script name and append '.pid' to it.

=cut

sub file
{
	my ( $self, $arg ) = @_;
	
	$self->{ file } = $arg if $arg;

	if ( ! defined $self->{ file } )
	{
		my @filename = fileparse( $0 );
		$self->{ file } = $Bin . '/';
		$self->{ file } .= shift @filename;
		$self->{ file } .= '.pid';
	}
	
	# relative paths are made absolute, but to the scripts dir
	
	if ( $self->{ file } !~ m:^/: )
	{
		$self->{ file } = $Bin . '/' . $self->{ file };
	}
	
	return $self->{ file };
}

=head3 create

Create a new pid file.

Returns true or false for whether the pid file was created.

If the file already exists, and the pid in that file is still running, no action will be taken and it will return false.

=cut

sub create
{
	my $self = shift;

	return 0 if $self->running;

	open my $fh, ">", $self->file or return 0;
	print $fh $$;
	close $fh;
	return 1;
}

=head3 running

Returns true or false to indicate whether the pid in the current pid file is running.

=cut

sub running
{
	my ( $self ) = @_;

	if ( ! -f $self->file )
	{
		return 0;
	}

	open my $fh, "<", $self->file or die "Failed to read " . $self->file . ": $!";
	my $pid = do { local $/; <$fh> };
	close $fh;

	return kill 0, $pid;

}

=head3 remove

Removes the pid file.

=cut


sub remove
{
	my $self = shift;
	
	unlink $self->file;

	return $self;
}

=head1 AUTHOR

Rob Brown, C<< <rob at intelcompute.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-pid-file at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=PID-File>.  I will be notified, and then you will
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc PID::File


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=PID-File>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/PID-File>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/PID-File>

=item * Search CPAN

L<http://search.cpan.org/dist/PID-File/>

=back


=head1 ACKNOWLEDGEMENTS

L<Daemon::Control>

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Rob Brown.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of PID::File

