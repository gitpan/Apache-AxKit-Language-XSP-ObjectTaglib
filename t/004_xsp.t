#!perl -wT
# $Id: 004_xsp.t 309 2005-03-05 17:05:21Z claco $
use strict;
use warnings;
require Test::More;

eval 'use Apache::Test 1.16';
Test::More::plan(skip_all =>
        'Apache::Test 1.16 required for AxKit Taglib tests') if $@;

eval 'use LWP::UserAgent';
Test::More::plan(skip_all =>
        'LWP::UserAgent required for Apache::Test cookie tests') if $@;

Apache::TestRequest->import(qw(GET));
Apache::TestRequest::user_agent( cookie_jar => {});
Apache::Test::plan(tests => 1,
    need('AxKit', 'mod_perl', &have_apache(1), &have_lwp));

my $courses = GET('/courses.xsp');
ok($courses->code == 200);
