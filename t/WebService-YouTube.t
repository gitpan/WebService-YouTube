#!/usr/bin/env perl
#
# $Revision: 37 $
# $Source$
# $Date: 2006-08-23 14:06:23 +0900 (Wed, 23 Aug 2006) $
#
use strict;
use warnings;
use version;
our $VERSION = version->new(qw$Revision: 37 $);

use blib;
use Test::More tests => 18;

use WebService::YouTube;

can_ok( 'WebService::YouTube', qw(new) );

SKIP: {
    can_ok( 'WebService::YouTube', qw(dev_id) );
    can_ok( 'WebService::YouTube',
        qw(videos_get_details videos_list_featured) );

    if ( !$ENV{dev_id} ) {
        skip 'set dev_id for testing WebService::YouTube', 1;
    }
    my $youtube = WebService::YouTube->new( { dev_id => $ENV{dev_id} } );
    my @videos = $youtube->videos_list_featured;
    cmp_ok( @videos, q{==}, 25, 'youtube.videos.list_featured' );
}
TODO: {
    todo_skip 'These have not been implemented yet', 2;

    # youtube.users.*
    can_ok( 'WebService::YouTube::Users',
        qw(get_profile list_favorite_videos list_friends) );

    # youtube.videos.*
    can_ok( 'WebService::YouTube::Videos',
        qw(get_details list_by_tag list_by_user list_featured) );
}

my @rss_methods = qw(
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

my $youtube = WebService::YouTube->new;
can_ok( $youtube, @rss_methods );
foreach my $method (@rss_methods) {
    cmp_ok( $youtube->$method, q{==}, 15, "$method.rss" );
}
