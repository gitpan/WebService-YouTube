#
# $Id: Build.PL 11 2007-04-09 04:34:01Z hironori.yoshida $
#
use strict;
use warnings;
our $VERSION = eval { require version; version::qv('1.0.1') };

do 'Makefile.PL';
