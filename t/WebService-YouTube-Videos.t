#!/usr/bin/env perl
#
# $Revision: 139 $
# $Source$
# $Date: 2006-09-11 13:38:53 +0900 (Mon, 11 Sep 2006) $
#
use strict;
use warnings;
use version; our $VERSION = qv( (qw$Revision: 139 $)[1] / 1000 );

use blib;
use Test::More tests => 6;

use WebService::YouTube::Videos;

can_ok( 'WebService::YouTube::Videos', qw(new dev_id) );
can_ok(
    'WebService::YouTube::Videos',
    qw(
      get_details
      list_by_tag
      list_by_user
      list_featured
      )
);

SKIP: {
    if ( !$ENV{TEST_YOUTUBE} ) {
        skip 'set TEST_YOUTUBE for testing WebService::YouTube::Videos', 4;
    }
    my $api =
      WebService::YouTube::Videos->new( { dev_id => $ENV{TEST_YOUTUBE} } );
    my @videos = $api->list_featured;
    cmp_ok( @videos, q{==}, 25, 'youtube.videos.list_featured' );

    @videos = $api->list_by_user('youtuberocks');
    cmp_ok( @videos, q{==}, 0, 'youtube.videos.list_by_user' );

    @videos = $api->list_by_tag('feature film documentary');
    cmp_ok( @videos, q{>}, 0, 'youtube.videos.list_by_tag' );

    my $video = $api->get_details( $videos[0] );
    ok( $video, 'youtube.videos.get_details' );
}
