#!/usr/bin/env perl
#
# $Revision: 120 $
# $Source$
# $Date: 2006-09-09 19:51:11 +0900 (Sat, 09 Sep 2006) $
#
use strict;
use warnings;
use version;
our $VERSION = version->new(qw$Revision: 120 $);

use blib;
use English qw(-no_match_vars);
use Test::More tests => 6;

our $WHY_SKIP_SAWAMPERSAND;

BEGIN {
    if ( $ENV{TEST_MATCH_VARS} || $ENV{TEST_ALL} ) {
        eval {
            require Devel::SawAmpersand;
            Devel::SawAmpersand->import(qw(sawampersand));
        };
        if ($EVAL_ERROR) {
            $WHY_SKIP_SAWAMPERSAND =
              'Devel::SawAmpersand required for testing sawampersand';
        }
    }
    else {
        $WHY_SKIP_SAWAMPERSAND = 'set TEST_MATCH_VARS for testing sawampersand';
    }

    use_ok('WebService::YouTube');
    use_ok('WebService::YouTube::Feeds');
    use_ok('WebService::YouTube::Util');
    use_ok('WebService::YouTube::Video');
    use_ok('WebService::YouTube::Videos');
}

# run sawampersand test if Devel::SawAmpersand is installed.
SKIP: {
    if ($WHY_SKIP_SAWAMPERSAND) {
        skip $WHY_SKIP_SAWAMPERSAND, 1;
    }
    isnt( sawampersand(), 1, q{$`, $&, and $' should not appear} ); ## no critic
}
