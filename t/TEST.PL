#!perl
# $Id: TEST.PL,v 1.1 2004/11/29 03:42:47 claco Exp $

use strict;
use warnings FATAL => 'all';
use lib qw(lib);

use Apache::TestRunPerl ();

Apache::TestRunPerl->new->run(@ARGV);
