# $Id: Makefile.PL 377 2005-03-10 02:56:40Z claco $
use strict;
use warnings;
use ExtUtils::MakeMaker;

eval 'use Apache::Test 1.16';
if (!$@) {
    require Apache::TestMM;
    Apache::TestMM->import(qw(test clean));

    ## for whatever reason, use AxKit causes issues
    ## use-ing A::A::Exception doesn't
    eval 'use Apache::AxKit::Exception';
    if (!$@) {
        push(@ARGV, '-defines', 'AXKIT');
    };

    Apache::TestMM::filter_args();
    Apache::TestMM::generate_script('t/TEST');
    Apache::TestMM::generate_script('t/SMOKE');
};

WriteMakefile(
    NAME            => 'Apache::AxKit::Language::XSP::ObjectTaglib',
    VERSION_FROM    => 'lib/Apache/AxKit/Language/XSP/ObjectTaglib.pm',
    ABSTRACT        => 'XSP helper for OO Taglibs',
    ($] >= 5.005 ?
        (AUTHOR     => 'Christopher H. Laco <claco@chrislaco.com>') : ()),
    PREREQ_PM       => {
        'AxKit'     =>  1.62
    },
    (ExtUtils::MakeMaker->VERSION >= 6.11) ?
    (NO_META        => 1) : (),
    clean           =>  {
        FILES => "t/TEST t/SMOKE smoke-report-* t/logs"
    }
);
