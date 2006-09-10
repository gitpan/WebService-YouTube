#!/usr/bin/env perl
#
# $Revision: 121 $
# $Source$
# $Date: 2006-09-09 20:38:13 +0900 (Sat, 09 Sep 2006) $
#
use strict;
use warnings;
use version;
our $VERSION = version->new(qw$Revision: 121 $);

use blib;
use Test::More tests => 6;

use WebService::YouTube;

can_ok( 'WebService::YouTube', qw(new dev_id ua) );
can_ok( 'WebService::YouTube', qw(videos feeds) );

my $youtube = WebService::YouTube->new;
isa_ok( $youtube->feeds, 'WebService::YouTube::Feeds' );

SKIP: {
    if ( !$ENV{TEST_YOUTUBE} ) {
        skip 'set TEST_YOUTUBE for testing WebService::YouTube', 1;
    }
    $youtube->dev_id( $ENV{TEST_YOUTUBE} );
    isa_ok( $youtube->videos, 'WebService::YouTube::Videos' );
}

TODO: {
    todo_skip 'These have not been implemented yet', 2;

    # youtube.users.*
    can_ok( $youtube, qw(users) );
    isa_ok( $youtube->users, 'WebService::YouTube::Users' );
}
