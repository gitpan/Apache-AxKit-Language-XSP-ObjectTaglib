package Apache::AxKit::Language::XSP::ObjectTaglib;
use strict;
use vars qw/@ISA $VERSION @EXPORT/;
use Apache::AxKit::Language::XSP;
$VERSION = "0.01";
use Exporter;
@ISA = ('Apache::AxKit::Language::XSP', 'Exporter');

@EXPORT = qw(parse_start parse_end);

my %stacks;

sub parse_char {
    my ($e, $text) = @_;

    $text =~ s/^\s*//;
    $text =~ s/\s*$//;

    return '' unless $text;

    $text =~ s/\|/\\\|/g;
    return ". q|$text|";
}

sub parse_start {
    my ($e, $tag, %attr) = @_;
    $tag =~ s/-/_/g;
    my $ns = $e->{Current_Element}->{NamespaceURI};
    my $where = $Apache::AxKit::Language::XSP::tag_lib{ $ns };
    push @{$stacks{$where}}, $tag;
    my ($safe_where, @specification);
    { 
        no strict 'refs'; @specification = @{"${where}::specification"}; 
        die "No specification found in $where!" unless @specification;
    }

    ($safe_where = lc $where) =~ s/::/_/g;
    s/\|//g for %attr;

    for (@specification) {
        next unless $tag eq $_->{tag};
        if (defined $_->{context} ) { 
            next unless $_->{context} eq $stacks{$where}->[-2];
        }

        return $_->{start}->($e, $tag, %attr)
            if $_->{type} eq "special";
        
        if ($_->{type} eq "loop") { 
            $e->manage_text(0);
            my $iterator = $_->{iterator};
            my $target = $_->{target};
            return <<EOF
for my \$_xsp_${safe_where}_$iterator (\$_xsp_${safe_where}_${target}->$tag) {
EOF
        }
        $e->start_expr($tag) unless $_->{type} eq "as_xml";
        return '';
    }
    die "Unknown start tag $tag\n";
}

sub parse_end {
    my ($e, $tag, %attr) = @_;
    $tag =~ s/-/_/g;
    my $where = $AxKit::XSP::TaglibPkg;
    pop @{$stacks{$where}};
    my ($safe_where, @specification);
    { no strict 'refs'; @specification = @{"${where}::specification"}; }

    ($safe_where = lc $where) =~ s/::/_/g;

    for (@specification) {
        next unless $tag eq $_->{tag};
        if (defined $_->{context} ) { 
            next unless $_->{context} eq $stacks{$where}->[-1];
        }

        return $_->{end}->($e, $tag, %attr)
            if $_->{type} eq "special";

        my $target = $_->{target};

        if ($_->{type} eq "loop") {
            $e->manage_text(0);
            return "}";
        } elsif ($_->{type} eq "as_xml") {
            $e->manage_text(0);
            my $util_include_expr = {
                        Name => 'include-expr',
                        NamespaceURI => $AxKit::XSP::Util::NS,
                        Attributes => [],
                    };
            my $xsp_expr = {
                        Name => 'expr',
                        NamespaceURI => $AxKit::XSP::Core::NS,
                        Attributes => [],
                    };
            $e->start_element($util_include_expr);
            $e->start_element($xsp_expr);
            $e->append_to_script(<<EOF);
    '<some-obvious-grouping-tag>'.\$_xsp_${safe_where}_$target->$tag().'</some-obvious-grouping-tag>'
EOF
            $e->end_element($xsp_expr);
            $e->end_element($util_include_expr);
            return ''
        }

        $e->append_to_script("(\$_xsp_${safe_where}_$target->$tag()".
            ($_->{notnull} && "|| q|<p></p>|").");");
        $e->end_expr();
        return "";
    }
    die "Unknown end tag $tag\n";
}
1;


=head1 NAME

Apache::AxKit::Language::XSP::ObjectTaglib - Helper for OO Taglibs

=head1 SYNOPSIS

    package MyTaglib;
    use Apache::AxKit::Language::XSP::ObjectTaglib;
    @ISA = qw(Apache::AxKit::Language::XSP::ObjectTaglib);

    @specification = (
        ...
    );

=head1 DESCRIPTION

This is an AxKit tag library helper for easily wrapping object-oriented
classes into XSP tags. The interface to the class is through a
specification which your taglib provides as a package variable. You may
wrap single or multiple classes within the same taglib, iterate over
several objects, and call methods on a given object.

Here is a sample specification:

    @specification = (
    { tag => "name", context => "resources", target => "resource" },

    { tag => "courses", type => "special",
                        start => \&start_courses, end => \&end_courses },

    { tag => "name",  target => "course" },
    { tag => "code",  target => "course" },

    { tag => "presentations",
        target => "course", type => "loop", iterator => "presentation" },
    { tag => "prerequisites",
        target => "course", type => "loop", iterator => "course" },

    { tag => "description", target => "course", type => "as_xml" },
    { tag => "summary",     target => "course", type => "as_xml" },

    ...

    { tag => "size",          target => "presentation", notnull => 1 },
   );

Here's what this means:

    { tag => "name", context => "resources", target => "resource" },

Define a tag called C<name> which occurs inside of another tag called
C<resources>. (We'll define a top-level C<name> tag later, so this
context-sensitive override has to come first.) When this tag is seen,
the method C<name> will be called on the variable
C<$_xsp_axkit_xsp_coursebooking_resource>. (This example is taken from the
C<AxKit::XSP::CourseBooking> taglib, and so all variable names used by
the example taglib start with C<_xsp_axkit_xsp_coursebooking_>.)

    { tag => "courses", type => "special",
                        start => \&start_courses, end => \&end_courses },

C<courses> will be the main entry point for our tag library, and as such
needs to do some special things to set itself up. Hence, it uses a 
C<special> type, and provides its own handlers to handle the start and
end tag events. These handlers will be responsible for setting up 
C<$_xsp_axkit_xsp_coursebooking_course>, used in the following tags, and
looping over the possible courses, setting
C<$_xsp_axkit_xsp_coursebooking_course> appropriately.

    { tag => "name",  target => "course" },
    { tag => "code",  target => "course" },

When we see the C<name> tag, we call the C<name> method on
C<$_xsp_axkit_xsp_coursebooking_course>. Similarly, the C<code> tag
calls the C<code> method on the same object.

    { tag => "presentations",
        target => "course", type => "loop", iterator => "presentation" },

Each course object has a C<presentations> method, which is wrapped by the
C<presentations> tag. This methods returns a list of objects representing
the presentations of a course; the C<presentations> tag sets up a loop,
with C<$_xsp_axkit_xsp_coursebooking_presentation> as the iterator. Hence,
inside of a C<presentations> tag, C<< target => "presentation" >> will cause
the method to be called on each presentation object in turn.

    { tag => "prerequisites",
        target => "course", type => "loop", iterator => "course" },

This is slightly dirty. We want a C<prerequisites> tag to refer to other
course objects, namely, the courses which are required for admission to
the current course. ie:

    <c:courses code="foo">
        For course <c:name/>, you need to take the following courses:

        <c:prerequisites>
            <li> <c:name/>
        </c:prerequisites>

    </c:courses>

So when we see the C<prerequisites> tag, we call the C<prerequisites>
method on our C<course> target, C<$_xsp_axkit_xsp_coursebooking_course>.
This returns a list of new course objects, which we loop over.
(C<type => "loop">)

Our loop iterator will be C<$_xsp_axkit_xsp_coursebooking_course>
itself, so the other tags will work properly on the iterated courses.

Some code is worth a thousand words. The generated Perl will look
something like this:

    for my $_xsp_axkit_xsp_coursebooking_course
        ($_xsp_axkit_xsp_coursebooking_course->prerequisites) {
        ... $_xsp_axkit_xsp_coursebooking_course->name ...
    }

Back to our specification:

    { tag => "description", target => "course", type => "as_xml" },
    { tag => "summary",     target => "course", type => "as_xml" },

These tags call the C<description> and C<summary> methods on the course
object, this time making sure that the result is valid XML instead of
plain text. (This is because we store the description in the database
as XML, and don't want it escaped before AxKit throws it onto the page.)

    { tag => "size",          target => "presentation", notnull => 1 },

When we see C<size>, we call the C<size> method on
C<$_xsp_axkit_xsp_coursebooking_presentation>, the presentation object
we set up in a loop above. We ensure that we get B<some> output back from
this method.

Here's another quick example:

    our @specification = (
        { tag => "person", type => "special",
                            start => \&start_person, end => \&end_person },
        { tag => "name", key => "cn", target => 'person'},
        ...
    );

This comes from a wrapper around LDAP. As before, the C<person> tag at
the top level has two subroutines to set up the C<person> target.
(which in this case will be C<$_xsp_axkit_xsp_ldap_person>) When a 
C<name> tag is seen inside of the C<person> tag, a method is called on
that target. This time, we use C<key> to say that the method name is
actually C<cn>, rather than C<name>. Hence the following XSP:

    <b:person dn="foo">
       <b:name/>
    </b:person>

generates something like this:

    {
    my $_xsp_axkit_xsp_ldap_person = somehow_get_ldap_object(dn => "foo");

       ...
       $_xsp_axkit_xsp_ldap_person->cn();
       ...
    }

All clear?

=head1 LICENSE

GPL/AL.

=head1 AUTHOR

Simon Cozens, C<simon@ermine.ox.ac.uk>.
