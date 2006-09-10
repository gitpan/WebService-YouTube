#!/usr/bin/env perl
#
# $Revision: 135 $
# $Source$
# $Date: 2006-09-10 14:55:11 +0900 (Sun, 10 Sep 2006) $
#
use strict;
use warnings;
our $VERSION = eval {
    require version;
    version->new(qw$Revision: 135 $);
};

use inc::Module::Install;
eval {
    require ExtUtils::MakeMaker::Coverage;
    ExtUtils::MakeMaker::Coverage->import;
};

name 'WebService-YouTube';
version '0.02';
all_from 'lib/WebService/YouTube.pm';

requires 'version';
requires 'Class::Accessor::Fast';
requires 'HTTP::Date';
requires 'LWP::UserAgent';
requires 'URI::Escape';
requires 'XML::Simple';

WriteAll;
