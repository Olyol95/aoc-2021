#!/usr/bin/env perl

use Modern::Perl;

use AoC::Solution::Day5;

use Test::More;

my $solution = AoC::Solution::Day5->new(
    input => join("\n", (
        '0,9 -> 5,9',
        '8,0 -> 0,8',
        '9,4 -> 3,4',
        '2,2 -> 2,1',
        '7,0 -> 7,4',
        '6,4 -> 2,0',
        '0,9 -> 2,9',
        '3,4 -> 1,4',
        '0,0 -> 8,8',
        '5,5 -> 8,2',
    )),
);

is($solution->part_1, 5, 'part_1');
is($solution->part_2, 12, 'part_2');

done_testing();
