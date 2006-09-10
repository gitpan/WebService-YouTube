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
use Test::More tests => 16;

use WebService::YouTube::Feeds;

can_ok( 'WebService::YouTube::Feeds', qw(new ua) );
my $feeds = WebService::YouTube::Feeds->new;

can_ok( $feeds, qw(tag user) );

my @global_rss = qw(
  recently_added
  recently_featured
  top_favorites
  top_rated
  most_discussed_month
  most_discussed_today
  most_discussed_week
  top_viewed
  top_viewed_month
  top_viewed_today
  top_viewed_week
);

can_ok( $feeds, @global_rss );

SKIP: {
    if ( !$ENV{TEST_YOUTUBE} ) {
        skip 'set TEST_YOUTUBE for testing WebService::YouTube::Feeds',
          @global_rss + 2;
    }
    ok( $feeds->tag('monkey'),   'tag' );
    ok( $feeds->user('YouTube'), 'user' );
    foreach my $rss (@global_rss) {
        cmp_ok( $feeds->$rss, q{==}, 15, $rss );
    }
}
