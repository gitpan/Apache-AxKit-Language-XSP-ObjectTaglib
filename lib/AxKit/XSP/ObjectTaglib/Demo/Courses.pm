# $Id: Courses.pm 125 2005-02-04 00:46:30Z claco $
package AxKit::XSP::ObjectTaglib::Demo::Courses;
use strict;

sub load {
    my @courses;

    require AxKit::XSP::ObjectTaglib::Demo::Course;
    push @courses, AxKit::XSP::ObjectTaglib::Demo::Course->new({
        name => 'Course 1',
        code => 'c123',
        summary => '<p>Course 1 Summary</p>',
        description => '<p>Descrption</p>'
    });

    push @courses, AxKit::XSP::ObjectTaglib::Demo::Course->new({
        name => 'Course 2',
        code => 'c234',
        summary => '<p>Course 2 Summary</p>',
        description => '<p>Descrption</p>'
    });

    push @courses, AxKit::XSP::ObjectTaglib::Demo::Course->new({
        name => 'Course 3',
        code => 'c345',
        summary => '<p>Course 3 Summary</p>',
        description => '<p>Descrption</p>'
    });

    return (@courses);
};

1;
__END__

=head1 NAME

AxKit::XSP::ObjectTaglib::Demo::Courses - A mock course collection object

=head1 SYNOPSIS

    use AxKit::XSP::ObjectTaglib::Demo::Courses;
    use strict;

    my @courses = AxKit::XSP::ObjectTaglib::Demo::Courses->load;
    for (@courses) {
        print $_->name;
    };

=head1 DESCRIPTION

This module represents a generic Courses object that loads a set of
C<AxKit::XSP::ObjectTaglib::Demo::Course> object for use within
the C<AxKit::XSP::ObjectTaglib::Demo> Taglib.

=head1 METHODS

=head2 load

Returns an array of C<AxKit::XSP::ObjectTaglib::Demo::Course> objects.

    my @courses = AxKit::XSP::ObjectTaglib::Demo::Courses->load;
    for (@courses) {
        print $_->name;
    };

=head1 AUTHOR

Christopher H. Laco <axkit@chrislaco.com>

=head1 SEE ALSO

L<AxKit::XSP::ObjectTaglib::Demo>,
L<Apache::AxKit::Language::XSP::ObjectTaglib>,
L<AxKit::XSP::ObjectTaglib::Demo::Course>
