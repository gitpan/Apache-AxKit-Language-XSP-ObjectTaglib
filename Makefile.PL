# $Id: Makefile.PL 125 2005-02-04 00:46:30Z claco $
use ExtUtils::MakeMaker;
use File::Spec::Functions;

my $test = catfile('t', 'TEST');

eval 'use Apache::Test 1.16';
if (!$@) {
    require Apache::TestMM;
    Apache::TestMM->import(qw(test clean));

    my @scripts = qw(t/TEST);

    Apache::TestMM::filter_args();
    Apache::TestMM::generate_script($test);

    mkdir($sessiondir, 777);
    mkdir($sessionlockdir, 777);
};

WriteMakefile(
    NAME            => 'Apache::AxKit::Language::XSP::ObjectTaglib',
    VERSION_FROM    => 'lib/Apache/AxKit/Language/XSP/ObjectTaglib.pm',
    ABSTRACT        => 'XSP helper for OO Taglibs',
    ($] >= 5.005 ?
        (AUTHOR     => 'Christopher H. Laco (axkit@chrislaco.com)') : ()),
    PREREQ_PM       => {
        'AxKit'     =>  undef
    },
    (ExtUtils::MakeMaker->VERSION >= 6.11) ?
    (NO_META        => 1) : (),
    clean           =>  {
        FILES => "$test"
    }
);
