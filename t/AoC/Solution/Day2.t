#!/usr/bin/env perl

use Modern::Perl;

use AoC::Solution::Day2;

use Test::More;

my $solution = AoC::Solution::Day2->new(
    input => join("\n", (
        'forward 5',
        'down 5',
        'forward 8',
        'up 3',
        'down 8',
        'forward 2',
    )),
);

is($solution->part_1, 150, 'part_1');
is($solution->part_2, 900, 'part_2');

done_testing();
