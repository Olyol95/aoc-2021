#!/usr/bin/env perl

use Modern::Perl;

use AoC::Solution::Day11;

use Test::More;

my $solution = AoC::Solution::Day11->new(
    input => join("\n", (
        '5483143223',
        '2745854711',
        '5264556173',
        '6141336146',
        '6357385478',
        '4167524645',
        '2176841721',
        '6882881134',
        '4846848554',
        '5283751526',
    )),
);

is($solution->part_1, 1656, 'part_1');
is($solution->part_2, 195, 'part_2');

done_testing();
