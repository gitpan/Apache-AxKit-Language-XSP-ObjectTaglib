#!perl
# $Id: TEST.PL 309 2005-03-05 17:05:21Z claco $
use strict;
use warnings FATAL => 'all';
use lib qw(lib);

use Apache::TestRunPerl ();

Apache::TestRunPerl->new->run(@ARGV);
