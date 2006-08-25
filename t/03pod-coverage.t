#!/usr/bin/env perl
#
# $Revision: 27 $
# $Source$
# $Date: 2006-08-11 17:15:41 +0900 (Fri, 11 Aug 2006) $
#
use strict;
use warnings;
use version;
our $VERSION = version->new(qw$Revision: 27 $);

use blib;
use English qw(-no_match_vars);
use FindBin qw($Bin);
use Test::More;

if ( $ENV{TEST_POD} || $ENV{TEST_ALL} ) {
    chdir "$Bin/..";
    eval {
        require Test::Pod::Coverage;
        Test::Pod::Coverage->import;
    };
    if ($EVAL_ERROR) {
        plan skip_all =>
          'Test::Pod::Coverage required for testing POD coverage';
    }
}
else {
    plan skip_all => 'set TEST_POD for testing POD coverage';
}

all_pod_coverage_ok();
