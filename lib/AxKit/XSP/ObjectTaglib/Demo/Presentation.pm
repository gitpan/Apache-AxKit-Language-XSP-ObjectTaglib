# $Id: Presentation.pm,v 1.1 2004/11/29 03:49:17 claco Exp $
package AxKit::XSP::ObjectTaglib::Demo::Presentation;
use strict;

sub new {
	my $class = shift;
	my $attr = shift || {};
	my $self = bless $attr, $class;

	return $self;
};

sub calculateSize {
	return (shift->{size} . 'Kb');
};

1;
__END__

=head1 NAME

AxKit::XSP::ObjectTaglib::Demo::Presentation - A mock course presentation object

=head1 SYNOPSIS

	use AxKit::XSP::ObjectTaglib::Demo::Presentation;
	use strict;

	my $presentation = AxKit::XSP::ObjectTaglib::Demo::Presentation->new();
	print $presentation->calculateSize;

=head1 DESCRIPTION

This module represents a generic Presentation object returned by
C<AxKit::XSP::ObjectTaglib::Demo::Course-E<gt>presentations> for use within
the C<AxKit::XSP::ObjectTaglib::Demo> Taglib.

=head1 METHODS

=head2 new( [\%attr] )

Returns a new C<AxKit::XSP::ObjectTaglib::Demo::Presentation> object. You can
also pass in an optional hashref to be blessed into the new object.

	my $presentation = AxKit::XSP::ObjectTaglib::Demo::Presentation->new({
		size => 100
	});

=head2 calculateSize

Returns the calculated size of the given
C<AxKit::XSP::ObjectTaglib::Demo::Presentation> object.

	print $presentation->calculatedSize;

=head1 AUTHOR

Christopher H. Laco <axkit@chrislaco.com>

=head1 SEE ALSO

L<AxKit::XSP::ObjectTaglib::Demo>, L<Apache::AxKit::Language::XSP::ObjectTaglib>
