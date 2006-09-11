#!/usr/bin/env perl
#
# $Revision: 139 $
# $Source$
# $Date: 2006-09-11 13:38:53 +0900 (Mon, 11 Sep 2006) $
#
use strict;
use warnings;
use version; our $VERSION = qv( (qw$Revision: 139 $)[1] / 1000 );

use English qw(-no_match_vars);
use FindBin qw($Bin);
use Test::More;

if ( $ENV{TEST_KWALITEE} || $ENV{TEST_ALL} ) {
    chdir "$Bin/..";
    eval {
        require Test::Kwalitee;
        Test::Kwalitee->import;
    };
    if ($EVAL_ERROR) {
        plan skip_all => 'Test::Kwalitee required for testing Kwalitee';
    }
}
else {
    plan skip_all => 'set TEST_KWALITEE for testing Kwalitee';
}
