# $Id: Makefile.PL,v 1.2 2004/11/29 03:39:51 claco Exp $
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
    NAME			=> 'Apache::AxKit::Language::XSP::ObjectTaglib',
    VERSION_FROM	=> 'lib/Apache/AxKit/Language/XSP/ObjectTaglib.pm',
    ABSTRACT		=> 'XSP helper for OO Taglibs',
    ($] >= 5.005 ?
        (AUTHOR		=> 'Christopher H. Laco (axkit@chrislaco.com)') : ()),
    PREREQ_PM		=> {
		'AxKit'		=>	undef
    },
	clean			=>	{
		FILES => "$test"
	}
);
