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

use WebService::YouTube::Video;

can_ok( 'WebService::YouTube::Video', qw(new) );

my $video = WebService::YouTube::Video->new;
isa_ok( $video, 'WebService::YouTube::Video' );

# derived from youtube.videos.get_details
can_ok(
    $video, qw(
      author
      title
      rating_avg
      rating_count
      tags
      description
      update_time
      view_count
      upload_time
      length_seconds
      recording_date
      recording_location
      recording_country
      comment_list
      channel_list
      thumbnail_url
      )
);

# derived from youtube.videos.list_by_tag
can_ok(
    $video, qw(
      author
      id
      title
      length_seconds
      rating_avg
      rating_count
      description
      view_count
      upload_time
      comment_count
      tags
      url
      thumbnail_url
      )
);

# derived from youtube.videos.list_by_user
can_ok(
    $video, qw(
      author
      id
      title
      length_seconds
      rating_avg
      rating_count
      description
      view_count
      upload_time
      comment_count
      tags
      url
      thumbnail_url
      )
);

# derived from youtube.videos.list_featured
can_ok(
    $video, qw(
      author
      id
      title
      length_seconds
      rating_avg
      rating_count
      description
      view_count
      upload_time
      comment_count
      tags
      url
      thumbnail_url
      )
);
