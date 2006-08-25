#
# $Revision: 42 $
# $Source$
# $Date: 2006-08-25 14:24:43 +0900 (Fri, 25 Aug 2006) $
#
package WebService::YouTube::Util;
use strict;
use warnings;
use version;
our $VERSION = version->new(qw$Revision: 42 $);

use LWP::Simple;

sub new {
    return bless {}, shift;
}

sub get_video_uri {
    my $self = shift;
    my ($video) = @_;

    if ( !$video ) {
        return;
    }

    my ( $video_id, $video_uri );
    if ( ref $video ) {
        $video_id  = $video->id;
        $video_uri = $video->url;
    }
    else {
        $video_id = $video;
    }
    $video_uri ||= "http://youtube.com/?v=$video_id";

    my $content = get($video_uri);
    if ( !$content ) {
        warn "$video_id: could not get a page of video";
        return;
    }
    if ( $content =~ m{"/player2\.swf\?([^"]+)",\s*"movie_player"}msx ) {
        return "http://youtube.com/get_video.php?$1";
    }

    if ( $content =~ m{class="errorBox"[^>]*>\s*([^<]+?)\s*<}msx ) {
        warn "$video_id: $1";
        return;
    }

    warn "$video_id: get a page but unknown error occurred at\n$content";
    return;
}

sub get_video {
    my $self = shift;
    my ($video) = @_;

    if ( !$video ) {
        return;
    }

    my $video_uri = $self->get_video_uri($video);
    if ( !$video_uri ) {
        return;
    }

    return get($video_uri);
}

1;

__END__

=head1 NAME

WebService::YouTube::Util - Utility for WebService::YouTube

=head1 VERSION

This document describes WebService::YouTube::Util $Revision: 42 $

=head1 SYNOPSIS

    use WebService::YouTube::Util;
    my $util = WebService::YouTube::Util->new;

=head1 DESCRIPTION

This is a utility for WebService::YouTube.

=head1 SUBROUTINES/METHODS

=head2 new( )

Creates and returns a new WebService::YouTube::Util object.

=head2 get_video_uri( $video )

Returns a downloadable URI of $video.
$video should be a video ID or WebService::YouTube::Video object.

=head2 get_video( $video )

Returns a downloaded content of $video.
$video should be a video ID or WebService::YouTube::Video object.

=head1 DIAGNOSTICS

=over

=back

=head1 CONFIGURATION AND ENVIRONMENT

WebService::YouTube::Util requires no configuration files or environment variables.

=head1 DEPENDENCIES

L<WebService::YouTube>, L<LWP::Simple>

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-webservice-youtube@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WebService-YouTube>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 AUTHOR

Hironori Yoshida C<< <yoshida@cpan.org> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2006, Hironori Yoshida C<< <yoshida@cpan.org> >>. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself. See L<perlartistic>.

=cut
