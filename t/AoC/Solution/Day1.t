#!/usr/bin/env perl

use Modern::Perl;

use AoC::Solution::Day1;

use Test::More;

my $solution = AoC::Solution::Day1->new(
    input => join("\n", (
        199,
        200,
        208,
        210,
        200,
        207,
        240,
        269,
        260,
        263,
    )),
);

is($solution->part_1, 7, 'part_1');
is($solution->part_2, 5, 'part_2');

done_testing();
