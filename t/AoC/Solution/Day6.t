#!/usr/bin/env perl

use Modern::Perl;

use AoC::Solution::Day6;

use Test::More;

my $solution = AoC::Solution::Day6->new(
    input => "3,4,3,1,2",
);

is($solution->part_1, 5934, 'part_1');
is($solution->part_2, 26984457539, 'part_2');

done_testing();
