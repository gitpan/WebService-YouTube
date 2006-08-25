#
# $Revision: 44 $
# $Source$
# $Date: 2006-08-25 16:13:00 +0900 (Fri, 25 Aug 2006) $
#
package WebService::YouTube;
use strict;
use warnings;
use version;
our $VERSION = version->new(qw$Revision: 44 $);

use HTTP::Date;
use LWP::Simple;
use WebService::YouTube::Video;
use XML::Simple;

use base qw(Class::Accessor::Fast);

__PACKAGE__->mk_accessors(qw(dev_id));

sub parse_xml {
    my $self = shift;
    my ($xml) = @_;

    my $ut_response =
      eval { XMLin( $xml, ForceArray => [qw(comment channel)] ) };
    if ( !$ut_response || $ut_response->{status} ne 'ok' ) {
        warn sprintf "status: %s\ncode: %d\ndescription: %s\n%s",
          $ut_response->{status}, $ut_response->{error}->{code},
          $ut_response->{error}->{description}, $xml;

=begin comment

1 : YouTube Internal Error
    This is a potential issue with the YouTube API. Please report the issue to us using the subject "Developer Question."
2 : Bad XML-RPC format parameter
    The parameter passed to the XML-RPC API call was of an incorrect type. Please see the XML-RPC interface documentation for more details.
3 : Unknown parameter specified
    Please double-check that the specified parameters match those in the API reference.
4 : Missing required parameter
    Please double-check that all required parameters for the API method you're calling are present in your request.
5 : No method specified
    All API calls must specify a method name.
6 : Unknown method specified
    Please check that you've spelled the method name correctly.
7 : Missing dev_id parameter
    All requests must have a developer ID. If you don't have one, please create a developer profile.
8 : Bad or unknown dev_id specified
    All requests must have a valid developer ID. If you don't have one, please create a developer profile.

=end comment

=cut

        return;
    }

    if ( exists $ut_response->{video_list} ) {
        my $video_list = $ut_response->{video_list}->{video};
        my @videos;
        foreach my $video_id ( keys %{$video_list} ) {
            my $video =
              WebService::YouTube::Video->new( $video_list->{$video_id} );
            $video->id($video_id);
            push @videos, $video;
        }
        return @videos;
    }
    elsif ( exists $ut_response->{video_details} ) {
        my $video =
          WebService::YouTube::Video->new( $ut_response->{video_details} );
        return $video;
    }
    else {
        warn sprintf '%s: unknown response at %s',
          [ keys %{$ut_response} ]->[0], $ut_response;
        return;
    }
}

sub videos_list_featured {
    my $self = shift;

    if ( !$self->dev_id ) {
        warn 'dev_id is not defined';
        return;
    }
    return $self->parse_xml(
        get(
                'http://www.youtube.com/api2_rest?dev_id='
              . $self->dev_id
              . '&method=youtube.videos.list_featured'
        )
    );
}

sub videos_get_details {
    my $self     = shift;
    my $video_id = shift;

    if ( !$self->dev_id ) {
        warn 'dev_id is not defined';
        return;
    }

    my $video = $self->parse_xml(
        get(
            sprintf
'http://www.youtube.com/api2_rest?dev_id=%s&method=youtube.videos.get_details&video_id=%s',
            $self->dev_id,
            $video_id
        )
    );
    if ($video) {
        $video->id($video_id);
    }
    return $video;
}

sub parse_rss {
    my $self = shift;
    my ($rss) = @_;

    # hack for the problem caused by control code.
    $rss and $rss =~ s{(=KjYe06lbN7U[^\x03]+)\x03}{$1}gmsx;

    my $result = XMLin(
        $rss,
        NSExpand => 1,    # because the prefix "media:" is just an alias.
    );

    # These are different between each RSS.
    if ( !$result->{channel}->{link} ) {
        warn qq{!$result->{channel}->{link}};
    }
    if ( !$result->{channel}->{title} ) {
        warn qq{!$result->{channel}->{title}};
    }
    if ( !$result->{channel}->{description} ) {
        warn qq{!$result->{channel}->{description}};
    }
    my $mrss = 'http://search.yahoo.com/mrss';    # namespace

    # extract data
    my @videos;
    foreach my $item ( @{ $result->{channel}->{item} } ) {
        my $author = $item->{"{$mrss}credit"};
        my $url    = $item->{"{$mrss}player"}->{url};
        ( my $id = $url ) =~ s/^.+\?v=//msx;
        my $title          = $item->{"{$mrss}title"};
        my $length_seconds = $item->{enclosure}->{length};
        my $upload_time    = str2time( $item->{pubDate} );
        my $tags           = $item->{"{$mrss}category"}->{content};
        my $thumbnail_url  = $item->{"{$mrss}thumbnail"}->{url};

        my $description_xhtml = $item->{description};
        my ($description) =
          $description_xhtml =~ m{.+<p>\s+(.+?)\s+</p>\s+<p>}msx;

        my $thumbnail_width  = $item->{"{$mrss}thumbnail"}->{width};
        my $thumbnail_height = $item->{"{$mrss}thumbnail"}->{height};

        # assertion
        if ( $item->{"{$mrss}category"}->{label} ne 'Tags' ) {
            warn qq{$item->{"{$mrss}category"}->{label} ne 'Tags'};
        }
        if ( $item->{enclosure}->{url} ne "http://youtube.com/v/$id.swf" ) {
            warn
              qq{$item->{enclosure}->{url} ne "http://youtube.com/v/$id.swf"};
        }
        if ( $item->{enclosure}->{type} ne 'application/x-shockwave-flash' ) {
            warn
              qq{$item->{enclosure}->{type} ne 'application/x-shockwave-flash'};
        }
        if ( $item->{author} ne "rss\@youtube.com ($author)" ) {
            warn qq{$item->{author} ne "rss\@youtube.com ($author)"};
        }
        if ( $item->{title} ne $title ) {
            warn qq{$item->{title} ne $title};
        }
        if ( $item->{guid}->{isPermaLink} ne 'true' ) {
            warn qq{$item->{guid}->{isPermaLink} ne 'true'};
        }
        if ( $item->{guid}->{content} ne $url ) {
            warn qq{$item->{guid}->{content} ne $url};
        }
        if ( $item->{link} ne $url ) {
            warn qq{$item->{link} ne $url};
        }

        my $video = WebService::YouTube::Video->new(
            {
                author         => $author,
                id             => $id,
                title          => $title,
                length_seconds => $length_seconds,
                rating_avg     => undef,
                rating_count   => undef,
                description    => $description,
                view_count     => undef,
                upload_time    => $upload_time,
                comment_count  => undef,
                tags           => $tags,
                url            => $url,
                thumbnail_url  => $thumbnail_url,
            }
        );
        push @videos, $video;
    }
    return @videos;
}

sub recently_added {
    my $self = shift;
    return $self->parse_rss(
        get('http://youtube.com/rss/global/recently_added.rss') );
}

sub recently_featured {
    my $self = shift;
    return $self->parse_rss(
        get('http://youtube.com/rss/global/recently_featured.rss') );
}

sub top_favorites {
    my $self = shift;
    return $self->parse_rss(
        get('http://youtube.com/rss/global/top_favorites.rss') );
}

sub top_rated {
    my $self = shift;
    return $self->parse_rss(
        get('http://youtube.com/rss/global/top_rated.rss') );
}

sub most_discussed_month {
    my $self = shift;
    return $self->parse_rss(
        get('http://youtube.com/rss/global/most_discussed_month.rss') );
}

sub most_discussed_today {
    my $self = shift;
    return $self->parse_rss(
        get('http://youtube.com/rss/global/most_discussed_month.rss') );
}

sub most_discussed_week {
    my $self = shift;
    return $self->parse_rss(
        get('http://youtube.com/rss/global/most_discussed_week.rss') );
}

sub top_viewed {
    my $self = shift;
    return $self->parse_rss(
        get('http://youtube.com/rss/global/top_viewed.rss') );
}

sub top_viewed_month {
    my $self = shift;
    return $self->parse_rss(
        get('http://youtube.com/rss/global/top_viewed_month.rss') );
}

sub top_viewed_today {
    my $self = shift;
    return $self->parse_rss(
        get('http://youtube.com/rss/global/top_viewed_today.rss') );
}

sub top_viewed_week {
    my $self = shift;
    return $self->parse_rss(
        get('http://youtube.com/rss/global/top_viewed_week.rss') );
}

1;

__END__

=head1 NAME

WebService::YouTube - Perl interfece to YouTube

=head1 VERSION

This document describes WebService::YouTube $Revision: 44 $

=head1 SYNOPSIS

    use WebService::YouTube;
    
    my $youtube = WebService::YouTube->new( { dev_id => YOUR_DEV_ID } );
    
    # Call API youtube.videos.list_featured
    my @videos = $youtube->videos_list_featured;
    foreach my $video (@videos) {
        # $video->isa('WebService::YouTube::Video');
    }

or

    use WebService::YouTube;
    
    my $youtube = WebService::YouTube->new;
    
    # Call RSS API recently_added
    my @videos = $youtube->recently_added;
    foreach my $video (@videos) {
        # $video->isa('WebService::YouTube::Video');
    }

=head1 DESCRIPTION

This is a Perl interface for YouTube API and RSS.
See Developers Page L<http://youtube.com/dev> and About RSS L<http://www.youtube.com/rssls> for details.

=head1 SUBROUTINES/METHODS

=head2 new(\%fields)

Creates and returns a new WebService::YouTube object.
%fields can contain parameters enumerated in L</ACCESSORS> section.

=head2 parse_xml($xml)

Parses XML and returns the result.
$xml should be an object that L<XML::Simple> can understand.

=head2 videos_list_featured( )

Returns an array of parsed result.

See L<http://youtube.com/dev_api_ref?m=youtube.videos.list_featured> for details.

=head2 videos_get_details( $video_id )

Returns an array of parsed result.

See L<http://youtube.com/dev_api_ref?m=youtube.videos.get_details> for details.

=head2 parse_rss($rss)

Parses RSS and returns the result.
$rss should be an object that L<XML::Simple> can understand.

=head2 recently_added( )

Returns an array of parsed result.

See L<http://youtube.com/rssls> for details.

=head2 recently_featured( )

Returns an array of parsed result.

See L<http://youtube.com/rssls> for details.

=head2 top_favorites( )

Returns an array of parsed result.

See L<http://youtube.com/rssls> for details.

=head2 top_rated( )

Returns an array of parsed result.

See L<http://youtube.com/rssls> for details.

=head2 most_discussed_month( )

Returns an array of parsed result.

See L<http://youtube.com/rssls> for details.

=head2 most_discussed_today( )

Returns an array of parsed result.

See L<http://youtube.com/rssls> for details.

=head2 most_discussed_week( )

Returns an array of parsed result.

See L<http://youtube.com/rssls> for details.

=head2 top_viewed( )

Returns an array of parsed result.

See L<http://youtube.com/rssls> for details.

=head2 top_viewed_month( )

Returns an array of parsed result.

See L<http://youtube.com/rssls> for details.

=head2 top_viewed_today( )

Returns an array of parsed result.

See L<http://youtube.com/rssls> for details.

=head2 top_viewed_week( )

Returns an array of parsed result.

See L<http://youtube.com/rssls> for details.

=head2 ACCESSORS

=over

=item dev_id : Developer ID

=back

=head1 DIAGNOSTICS

=over

=item dev_id is not defined

Developer ID is required when you call API of YouTube.

=back

=head1 CONFIGURATION AND ENVIRONMENT

WebService::YouTube requires no configuration files or environment variables.

=head1 DEPENDENCIES

L<version>, L<Class::Accessor::Fast>, L<LWP::Simple>, L<XML::Simple>

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
