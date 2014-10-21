#
# $Revision: 42 $
# $Source$
# $Date: 2006-08-25 14:24:43 +0900 (Fri, 25 Aug 2006) $
#
package WebService::YouTube::Video;
use strict;
use warnings;
use version;
our $VERSION = version->new(qw$Revision: 42 $);

use base qw(Class::Accessor::Fast);

# derived from youtube.videos.get_details
__PACKAGE__->mk_accessors(
    qw(
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

# derived from youtube.videos.list_featured
__PACKAGE__->mk_accessors(
    qw(
      id
      comment_count
      url
      )
);

1;

__END__

=head1 NAME

WebService::YouTube::Video - Video class for WebService::YouTube

=head1 VERSION

This document describes WebService::YouTube::Video $Revision: 42 $

=head1 SYNOPSIS

    use WebService::YouTube::Video;
    my $video = WebService::YouTube::Video->new( { ... } );

=head1 DESCRIPTION

This is a class of YouTube video information.

=head1 SUBROUTINES/METHODS

=head2 new(\%fields)

Creates and returns a new WebService::YouTube::Video object.
%fields can contain parameters enumerated in L</ACCESSORS> section.

=head2 ACCESSORS

=over

=item id : Video ID

=item author

=item comment_count

=item description

=item length_seconds

=item rating_avg

=item rating_count

=item tags

=item thumbnail_url

=item title

=item upload_time

=item url

=item view_count

=back

=head1 DIAGNOSTICS

=over

=back

=head1 CONFIGURATION AND ENVIRONMENT

WebService::YouTube::Video requires no configuration files or environment variables.

=head1 DEPENDENCIES

L<WebService::YouTube>, L<Class::Accessor::Fast>

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
