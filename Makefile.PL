use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'Apache::AxKit::Language::XSP::ObjectTaglib',
    VERSION_FROM => 'lib/Apache/AxKit/Language/XSP/ObjectTaglib.pm',
    ABSTRACT     => 'XSP helper for OO Taglibs',
    ($] >= 5.005 ?
        (AUTHOR  => 'Christopher H. Laco (axkit@chrislaco.com)') : ()),
    PREREQ_PM    => {
    	'Apache::AxKit::Language::XSP' => undef
    }
);
