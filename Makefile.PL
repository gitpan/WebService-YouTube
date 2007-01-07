#!/usr/bin/env perl
#
# $Id: Makefile.PL 2 2007-01-07 14:27:35Z hironori.yoshida $
#
use strict;
use warnings;
our $VERSION = eval { require version; version::qv('1.0.0') };

use inc::Module::Install;
eval {
    require ExtUtils::MakeMaker::Coverage;
    ExtUtils::MakeMaker::Coverage->import;
};

name 'WebService-YouTube';
version "$VERSION";
perl_version '5.006';
all_from 'lib/WebService/YouTube.pm';

requires 'version';
requires 'Class::Accessor::Fast';
requires 'HTTP::Date';
requires 'LWP::UserAgent';
requires 'URI::Escape';
requires 'XML::Simple';

auto_install;
use_test_base;

WriteAll;
