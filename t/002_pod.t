# $Id: 002_pod.t 125 2005-02-04 00:46:30Z claco $
use Test::More;

eval 'use Test::Pod 1.00';
plan skip_all => 'Test::Pod 1.00 required for testing pod syntax' if $@;

all_pod_files_ok();
