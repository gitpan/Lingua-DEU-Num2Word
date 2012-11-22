#!/usr/bin/env perl
# For Emacs: -*- mode:cperl; mode:folding -*-
#
# Copyright (C) PetaMem, s.r.o. 2009-present
#

# {{{ use block

use strict;
use warnings;
use utf8;

use Test::More;

# }}}

# {{{ basic tests

my $tests;

BEGIN {
    use_ok('Lingua::DEU::Num2Word');
    $tests++;
}

use Lingua::DEU::Num2Word           qw(:ALL);

# }}}

# {{{ num2deu_cardinal

 my $n2d = [
     [
         7,
         'sieben',
         '7'
     ],
     [
         186,
         'einhundertsechsundachtzig',
         '186'
     ],
     [
         1000,
         'eintausend',
         '1000'
     ],
     [
         100000000000,
         undef,
         'out of range'
     ],
     [
         undef,
         'null',
         'undef -> 0'
     ],
 ];

for my $test (@{$n2d}) {
    my $got = num2deu_cardinal($test->[0]);
    my $exp = $test->[1];
    is($got, $exp, $test->[2] . ' in German');
    $tests++;
}

# }}}

done_testing($tests);

__END__
