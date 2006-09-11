#
# $Revision: 139 $
# $Source$
# $Date: 2006-09-11 13:38:53 +0900 (Mon, 11 Sep 2006) $
#
package WebService::YouTube;
use strict;
use warnings;
use version; our $VERSION = qv( (qw$Revision: 139 $)[1] / 1000 );

use base qw(Class::Accessor::Fast);

__PACKAGE__->mk_accessors(qw(dev_id ua));

use Carp;
use WebService::YouTube::Feeds;
use WebService::YouTube::Videos;

sub videos {
    my $self = shift;

    $self->{_videos} ||= WebService::YouTube::Videos->new($self);
    return $self->{_videos};
}

sub feeds {
    my $self = shift;

    $self->{_feeds} ||= WebService::YouTube::Feeds->new($self);
    return $self->{_feeds};
}

sub parse_xml {
    my ( $self, $xml ) = @_;

    carp 'This is deprecated. Please see the document.';
    return WebService::YouTube::Videos->new($self)->parse_xml($xml);
}

sub videos_list_featured {
    my $self = shift;

    carp 'This is deprecated. Please see the document.';
    return WebService::YouTube::Videos->new($self)->list_featured;
}

sub videos_get_details {
    my ( $self, $video_id ) = @_;

    carp 'This is deprecated. Please see the document.';
    return WebService::YouTube::Videos->new($self)->get_details($video_id);
}

sub parse_rss {
    my ( $self, $rss ) = @_;

    carp 'This is deprecated. Please see the document.';
    return WebService::YouTube::Feeds->new($self)->parse_rss($rss);
}

sub recently_added {
    my $self = shift;

    carp 'This is deprecated. Please see the document.';
    return WebService::YouTube::Feeds->new($self)->recently_added;
}

sub recently_featured {
    my $self = shift;

    carp 'This is deprecated. Please see the document.';
    return WebService::YouTube::Feeds->new($self)->recently_featured;
}

sub top_favorites {
    my $self = shift;

    carp 'This is deprecated. Please see the document.';
    return WebService::YouTube::Feeds->new($self)->top_favorites;
}

sub top_rated {
    my $self = shift;

    carp 'This is deprecated. Please see the document.';
    return WebService::YouTube::Feeds->new($self)->top_rated;
}

sub most_discussed_month {
    my $self = shift;

    carp 'This is deprecated. Please see the document.';
    return WebService::YouTube::Feeds->new($self)->most_discussed_month;
}

sub most_discussed_today {
    my $self = shift;

    carp 'This is deprecated. Please see the document.';
    return WebService::YouTube::Feeds->new($self)->most_discussed_today;
}

sub most_discussed_week {
    my $self = shift;

    carp 'This is deprecated. Please see the document.';
    return WebService::YouTube::Feeds->new($self)->most_discussed_week;
}

sub top_viewed {
    my $self = shift;

    carp 'This is deprecated. Please see the document.';
    return WebService::YouTube::Feeds->new($self)->top_viewed;
}

sub top_viewed_month {
    my $self = shift;

    carp 'This is deprecated. Please see the document.';
    return WebService::YouTube::Feeds->new($self)->top_viewed_month;
}

sub top_viewed_today {
    my $self = shift;

    carp 'This is deprecated. Please see the document.';
    return WebService::YouTube::Feeds->new($self)->top_viewed_today;
}

sub top_viewed_week {
    my $self = shift;

    carp 'This is deprecated. Please see the document.';
    return WebService::YouTube::Feeds->new($self)->top_viewed_week;
}

1;

__END__

=head1 NAME

WebService::YouTube - Perl interfece to YouTube

=head1 VERSION

This document describes WebService::YouTube $Revision: 139 $

=head1 SYNOPSIS

    use WebService::YouTube;
    
    my $youtube = WebService::YouTube->new( { dev_id => 'YOUR_DEV_ID' } );
    
    # Get videos via REST API
    my @videos = $youtube->videos->list_featured;
    
    # Get videos via RSS Feed
    my @videos = $youtube->feeds->recently_added;

=head1 DESCRIPTION

This is a Perl interface to YouTube API and RSS.
See Developers Page L<http://youtube.com/dev> and About RSS L<http://www.youtube.com/rssls> for details.

=head1 SUBROUTINES/METHODS

=head2 new(\%fields)

Creates and returns a new WebService::YouTube object.
%fields can contain parameters enumerated in L</ACCESSORS> section.

=head2 videos( )

Returns a L<WebService::YouTube::Videos> object.

=head2 feeds( )

Returns a L<WebService::YouTube::Feeds> object.

=head2 ACCESSORS

=head3 dev_id

Developer ID

=head3 ua

L<LWP::UserAgent> object

=head1 DEPRECATED SUBROUTINES/METHODS

=head2 parse_xml($xml)

This is deprecated.
Please use L<WebService::YouTube::Videos/parse_xml>.

=head2 videos_list_featured( )

This is deprecated.
Please use L<WebService::YouTube::Videos/list_featured>.

=head2 videos_get_details( $video_id )

This is deprecated.
Please use L<WebService::YouTube::Videos/get_details>.

=head2 parse_rss($rss)

This is deprecated.
Please use L<WebService::YouTube::Feeds/parse_rss>.

=head2 recently_added( )

This is deprecated.
Please use L<WebService::YouTube::Feeds/recently_added>.

=head2 recently_featured( )

This is deprecated.
Please use L<WebService::YouTube::Feeds/recently_featured>.

=head2 top_favorites( )

This is deprecated.
Please use L<WebService::YouTube::Feeds/top_favorites>.

=head2 top_rated( )

This is deprecated.
Please use L<WebService::YouTube::Feeds/top_rated>.

=head2 most_discussed_month( )

This is deprecated.
Please use L<WebService::YouTube::Feeds/most_discussed_month>.

=head2 most_discussed_today( )

This is deprecated.
Please use L<WebService::YouTube::Feeds/most_discussed_today>.

=head2 most_discussed_week( )

This is deprecated.
Please use L<WebService::YouTube::Feeds/most_discussed_week>.

=head2 top_viewed( )

This is deprecated.
Please use L<WebService::YouTube::Feeds/top_viewed>.

=head2 top_viewed_month( )

This is deprecated.
Please use L<WebService::YouTube::Feeds/top_viewed_month>.

=head2 top_viewed_today( )

This is deprecated.
Please use L<WebService::YouTube::Feeds/top_viewed_today>.

=head2 top_viewed_week( )

This is deprecated.
Please use L<WebService::YouTube::Feeds/top_viewed_week>.

=head1 DIAGNOSTICS

=over

=item This is deprecated. Please see the document.

Some method have been deprecated in Version 0.02.

=back

=head1 CONFIGURATION AND ENVIRONMENT

WebService::YouTube requires no configuration files or environment variables.

=head1 DEPENDENCIES

L<Class::Accessor::Fast>, L<WebService::YouTube::Videos>, L<WebService::YouTube::Feeds>

=head1 INCOMPATIBILITIES

L<WWW::YouTube>

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

Copyright (c) 2006, Hironori Yoshida C<< <yoshida@cpan.org> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=cut
