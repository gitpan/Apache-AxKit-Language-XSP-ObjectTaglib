# $Id: 004_xsp.t 125 2005-02-04 00:46:30Z claco $
# Using require instead of use to avoid redefining errors
# when Apache::Test < 1.16 is installed
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
