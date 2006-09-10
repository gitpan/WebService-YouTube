#!/usr/bin/env perl
#
# $Revision: 133 $
# $Source$
# $Date: 2006-09-10 14:30:19 +0900 (Sun, 10 Sep 2006) $
#
use strict;
use warnings;
use version;
our $VERSION = version->new(qw$Revision: 133 $);

use blib;
use Test::More tests => 5;

use WebService::YouTube::Util;

can_ok(
    'WebService::YouTube::Util', qw(
      rss_uri
      rest_uri
      get_video_uri
      get_video
      )
);
is(
    WebService::YouTube::Util->rss_uri( 'global', 'arg' ),
    'http://www.youtube.com/rss/global/arg.rss',
    'rss_uri'
);
is(
    WebService::YouTube::Util->rest_uri(
        'dev_id', 'method', { key => 'value' }
    ),
    'http://www.youtube.com/api2_rest?dev_id=dev_id&method=method&key=value',
    'rest_uri'
);

SKIP: {
    if ( !$ENV{TEST_YOUTUBE} ) {
        skip 'set TEST_YOUTUBE for testing WebService::YouTube::Videos', 1;
    }
    ok( WebService::YouTube::Util->get_video_uri('rdwz7QiG0lk'),
        'Got URI of the video' );
}

SKIP: {
    skip 'It takes a long time', 1;
    ok( WebService::YouTube::Util->get_video('rdwz7QiG0lk'), 'Got the video' );
}
