#!/usr/bin/env perl

use Modern::Perl;

use AoC::Solution::Day3;

use Test::More;

my $solution = AoC::Solution::Day3->new(
    input => join("\n", (
        '00100',
        '11110',
        '10110',
        '10111',
        '10101',
        '01111',
        '00111',
        '11100',
        '10000',
        '11001',
        '00010',
        '01010',
    )),
);

is($solution->part_1, 198, 'part_1');
is($solution->part_2, 230, 'part_2');

done_testing();
