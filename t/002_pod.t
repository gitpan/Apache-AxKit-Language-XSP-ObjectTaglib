#!perl -wT
# $Id: 002_pod.t 309 2005-03-05 17:05:21Z claco $
use strict;
use warnings;
use Test::More;

eval 'use Test::Pod 1.00';
plan skip_all => 'Test::Pod 1.00 required for testing pod syntax' if $@;

all_pod_files_ok();