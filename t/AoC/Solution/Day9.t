#!/usr/bin/env perl

use Modern::Perl;

use AoC::Solution::Day9;

use Test::More;

my $solution = AoC::Solution::Day9->new(
    input => join("\n", (
        '2199943210',
        '3987894921',
        '9856789892',
        '8767896789',
        '9899965678',
    )),
);

is($solution->part_1, 15, 'part_1');
is($solution->part_2, 1134, 'part_2');

done_testing();
