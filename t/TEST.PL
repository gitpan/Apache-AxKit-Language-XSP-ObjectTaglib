#!perl
# $Id: TEST.PL 125 2005-02-04 00:46:30Z claco $

use strict;
use warnings FATAL => 'all';
use lib qw(lib);

use Apache::TestRunPerl ();

Apache::TestRunPerl->new->run(@ARGV);
