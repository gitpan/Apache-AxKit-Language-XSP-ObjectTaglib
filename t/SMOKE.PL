#!perl
# $Id: SMOKE.PL 315 2005-03-05 17:38:53Z claco $
use strict;
use warnings FATAL => 'all';
use lib qw(lib);

use Apache::TestSmoke ();

Apache::TestSmoke->new(@ARGV)->run;
