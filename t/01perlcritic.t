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

use English qw(-no_match_vars);
use FindBin qw($Bin);
use Test::More;

if ( $ENV{TEST_CRITIC} || $ENV{TEST_ALL} ) {
    chdir "$Bin/..";
    eval {
        my $format = "%l: %m (severity %s)\n";
        if ( $ENV{TEST_VERBOSE} ) {
            $format .= "%p\n%d\n";
        }
        require Test::Perl::Critic;
        Test::Perl::Critic->import( -format => $format, -severity => 1 );
    };
    if ($EVAL_ERROR) {
        plan skip_all =>
          'Test::Perl::Critic required for testing PBP compliance';
    }
}
else {
    plan skip_all => 'set TEST_CRITIC for testing PBP compliance';
}

all_critic_ok();
