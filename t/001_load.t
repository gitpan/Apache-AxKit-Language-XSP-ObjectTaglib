#!perl -wT
# $Id: 001_load.t 309 2005-03-05 17:05:21Z claco $
use strict;
use warnings;
use Test::More tests => 1;

BEGIN {
    use_ok( 'Apache::AxKit::Language::XSP::ObjectTaglib' );
};
