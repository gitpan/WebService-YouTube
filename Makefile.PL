#!/usr/bin/env perl
#
# $Revision: 145 $
# $Source$
# $Date: 2006-09-11 21:39:07 +0900 (Mon, 11 Sep 2006) $
#
use strict;
use warnings;
our $VERSION = eval { require version; version::qv( (qw$Revision: 145 $)[1] / 1000 ) };

use inc::Module::Install;
eval {
    require ExtUtils::MakeMaker::Coverage;
    ExtUtils::MakeMaker::Coverage->import;
};

name 'WebService-YouTube';
version '0.04';
perl_version '5.006';
all_from 'lib/WebService/YouTube.pm';

requires 'version';
requires 'Class::Accessor::Fast';
requires 'HTTP::Date';
requires 'LWP::UserAgent';
requires 'URI::Escape';
requires 'XML::Simple';

auto_install;

WriteAll;
