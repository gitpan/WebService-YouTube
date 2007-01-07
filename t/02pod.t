#!/usr/bin/env perl
#
# $Id: 02pod.t 2 2007-01-07 14:27:35Z hironori.yoshida $
#
use strict;
use warnings;
use version; our $VERSION = qv('1.0.0');

use English qw(-no_match_vars);
use FindBin qw($Bin);
use Test::Base;

if ( $ENV{TEST_POD} || $ENV{TEST_ALL} || !$ENV{HARNESS_ACTIVE} ) {
    chdir "$Bin/..";
    eval {
        require Test::Pod;
        Test::Pod->import;
    };
    if ($EVAL_ERROR) {
        plan skip_all => 'Test::Pod required for testing POD';
    }
}
else {
    plan skip_all => 'set TEST_POD for testing POD';
}

all_pod_files_ok();
