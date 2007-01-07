#!/usr/bin/env perl
#
# $Id: Build.PL 2 2007-01-07 14:27:35Z hironori.yoshida $
#
use strict;
use warnings;
our $VERSION = eval { require version; version::qv('1.0.0') };

do 'Makefile.PL';
