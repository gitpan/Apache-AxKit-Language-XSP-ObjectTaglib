# $Id: 002_pod.t,v 1.1 2004/11/29 03:42:47 claco Exp $
use Test::More;

eval 'use Test::Pod 1.00';
plan skip_all => 'Test::Pod 1.00 required for testing pod syntax' if $@;

all_pod_files_ok();
