# $Id: Prerequisite.pm 125 2005-02-04 00:46:30Z claco $
package AxKit::XSP::ObjectTaglib::Demo::Prerequisite;
use AxKit::XSP::ObjectTaglib::Demo::Course;
use strict;
use vars qw(@ISA);

@ISA = qw(AxKit::XSP::ObjectTaglib::Demo::Course);

1;
__END__

=head1 NAME

AxKit::XSP::ObjectTaglib::Demo::Prerequisite - A mock course prerequisite object

=head1 SYNOPSIS

    use AxKit::XSP::ObjectTaglib::Demo::Prerequisite;
    use strict;

    my $prerequisite = AxKit::XSP::ObjectTaglib::Demo::Prerequisite->new();
    print $prerequisite->name;

=head1 DESCRIPTION

This module represents a generic Prerequisite object returned by
C<AxKit::XSP::ObjectTaglib::Demo::Course-E<gt>prerequisites> for use within
the C<AxKit::XSP::ObjectTaglib::Demo> Taglib. A prerequisite object is simply a
course object in a different role. See L<AxKit::XSP::ObjectTaglib::Demo::Course>
for further documentation.

=head1 AUTHOR

Christopher H. Laco <axkit@chrislaco.com>

=head1 SEE ALSO

L<AxKit::XSP::ObjectTaglib::Demo>,
L<Apache::AxKit::Language::XSP::ObjectTaglib>,
L<AxKit::XSP::ObjectTaglib::Demo::Course>
