# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.08) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/e7yZMmQoJl/southamerica.  Olson data version 2022a
#
# Do not edit this file directly.
#
package DateTime::TimeZone::America::Guyana;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '2.52';

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::America::Guyana::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
60292093959, #      utc_end 1911-08-01 03:52:39 (Tue)
DateTime::TimeZone::NEG_INFINITY, #  local_start
60292080000, #    local_end 1911-08-01 00:00:00 (Tue)
-13959,
0,
'LMT',
    ],
    [
60292093959, #    utc_start 1911-08-01 03:52:39 (Tue)
60405105600, #      utc_end 1915-03-01 04:00:00 (Mon)
60292079559, #  local_start 1911-07-31 23:52:39 (Mon)
60405091200, #    local_end 1915-03-01 00:00:00 (Mon)
-14400,
0,
'-04',
    ],
    [
60405105600, #    utc_start 1915-03-01 04:00:00 (Mon)
62311779900, #      utc_end 1975-08-01 03:45:00 (Fri)
60405092100, #  local_start 1915-03-01 00:15:00 (Mon)
62311766400, #    local_end 1975-08-01 00:00:00 (Fri)
-13500,
0,
'-0345',
    ],
    [
62311779900, #    utc_start 1975-08-01 03:45:00 (Fri)
62837524800, #      utc_end 1992-03-29 04:00:00 (Sun)
62311769100, #  local_start 1975-08-01 00:45:00 (Fri)
62837514000, #    local_end 1992-03-29 01:00:00 (Sun)
-10800,
0,
'-03',
    ],
    [
62837524800, #    utc_start 1992-03-29 04:00:00 (Sun)
DateTime::TimeZone::INFINITY, #      utc_end
62837510400, #  local_start 1992-03-29 00:00:00 (Sun)
DateTime::TimeZone::INFINITY, #    local_end
-14400,
0,
'-04',
    ],
];

sub olson_version {'2022a'}

sub has_dst_changes {0}

sub _max_year {2032}

sub _new_instance {
    return shift->_init( @_, spans => $spans );
}



1;
