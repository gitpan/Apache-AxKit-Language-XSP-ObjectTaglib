use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Apache::AxKit::Language::XSP::ObjectTaglib',
    'VERSION_FROM'	=> 'ObjectTaglib.pm', # finds $VERSION
    'PREREQ_PM'		=> {
    Apache::AxKit::Language::XSP => 0
        }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'ObjectTaglib.pm', # retrieve abstract from module
       AUTHOR     => 'Simon Cozens <simon@cpan.org>') : ())
);
