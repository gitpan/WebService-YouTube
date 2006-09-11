#!/usr/bin/env perl
#
# $Revision: 141 $
# $Source$
# $Date: 2006-09-11 16:30:38 +0900 (Mon, 11 Sep 2006) $
#
use strict;
use warnings;
our $VERSION = eval { require version; version::qv( (qw$Revision: 141 $)[1] / 1000 ) };

do 'Makefile.PL';
