# $Id: Resource.pm,v 1.1 2004/11/29 03:49:17 claco Exp $
package AxKit::XSP::ObjectTaglib::Demo::Resource;
use strict;

sub new {
	my $class = shift;
	my $attr = shift || {};
	my $self = bless $attr, $class;

	return $self;
};

sub name {
	return shift->{name};
};

1;
__END__

=head1 NAME

AxKit::XSP::ObjectTaglib::Demo::Resource - A mock course resouce object

=head1 SYNOPSIS

	use AxKit::XSP::ObjectTaglib::Demo::Resource;
	use strict;

	my $resource = AxKit::XSP::ObjectTaglib::Demo::Resource->new();
	print $resource->name;

=head1 DESCRIPTION

This module represents a generic Resource object returned by
C<AxKit::XSP::ObjectTaglib::Demo::Course-E<gt>resources> for use within the
C<AxKit::XSP::ObjectTaglib::Demo> Taglib.

=head1 METHODS

=head2 new( [\%attr] )

Returns a new C<AxKit::XSP::ObjectTaglib::Demo::Resource> object. You can also
pass in an optional hashref to be blessed into the new object.

	my $resource = AxKit::XSP::ObjectTaglib::Demo::Resource->new({
		name => 'My Resource'
	});

=head2 name

Returns the name of the given C<AxKit::XSP::ObjectTaglib::Demo::Resource>
object.

	print $resource->name;

=head1 AUTHOR

Christopher H. Laco <axkit@chrislaco.com>

=head1 SEE ALSO

L<AxKit::XSP::ObjectTaglib::Demo>, L<Apache::AxKit::Language::XSP::ObjectTaglib>
