#!perl -wT
# $Id: 003_pod_coverage.t 309 2005-03-05 17:05:21Z claco $
use strict;
use warnings;
use Test::More;

eval 'use Test::Pod::Coverage 1.04';
plan skip_all =>
    'Test::Pod::Coverage 1.04 required for testing pod coverage' if $@;

plan tests => 7;

my $trustme = { also_private => [qr/^(parse_.*)$/] };
pod_coverage_ok( 'Apache::AxKit::Language::XSP::ObjectTaglib', $trustme );
pod_coverage_ok( 'AxKit::XSP::ObjectTaglib::Demo' );
pod_coverage_ok( 'AxKit::XSP::ObjectTaglib::Demo::Courses' );
pod_coverage_ok( 'AxKit::XSP::ObjectTaglib::Demo::Course' );
pod_coverage_ok( 'AxKit::XSP::ObjectTaglib::Demo::Prerequisite' );
pod_coverage_ok( 'AxKit::XSP::ObjectTaglib::Demo::Presentation' );
pod_coverage_ok( 'AxKit::XSP::ObjectTaglib::Demo::Resource' );
