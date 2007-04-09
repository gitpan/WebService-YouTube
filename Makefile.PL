#
# $Id: Makefile.PL 11 2007-04-09 04:34:01Z hironori.yoshida $
#
use strict;
use warnings;
our $VERSION = eval { require version; version::qv('1.0.1') };

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
