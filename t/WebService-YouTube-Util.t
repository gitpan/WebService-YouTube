#!/usr/bin/env perl
#
# $Revision: 29 $
# $Source$
# $Date: 2006-08-14 17:39:31 +0900 (Mon, 14 Aug 2006) $
#
use strict;
use warnings;
use version;
our $VERSION = version->new(qw$Revision: 29 $);

use blib;
use Test::More tests => 2;

use WebService::YouTube::Util;
use WebService::YouTube::Video;

can_ok( 'WebService::YouTube::Util', qw(new get_video_uri get_video) );
my $util = WebService::YouTube::Util->new;

my $video = WebService::YouTube::Video->new( { id => 'pv5zWaTEVkI' } );
my $uri = $util->get_video_uri($video);
ok( $uri, 'get URI of the video' );
