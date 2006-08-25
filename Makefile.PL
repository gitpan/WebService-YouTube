#!/usr/bin/env perl
#
# $Revision: 28 $
# $Source$
# $Date: 2006-08-14 16:09:44 +0900 (Mon, 14 Aug 2006) $
#
use strict;
use warnings;
our $VERSION = eval {
    require version;
    version->new(qw$Revision: 28 $);
};

use inc::Module::Install;
eval {
    require ExtUtils::MakeMaker::Coverage;
    ExtUtils::MakeMaker::Coverage->import;
};

name 'WebService-YouTube';
version '0.01';
all_from 'lib/WebService/YouTube.pm';

requires 'version'               => 0;
requires 'Class::Accessor::Fast' => 0;
requires 'LWP::Simple'           => 0;
requires 'XML::Simple'           => 0;

WriteAll;
