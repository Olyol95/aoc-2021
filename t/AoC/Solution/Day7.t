#!/usr/bin/env perl

use Modern::Perl;

use AoC::Solution::Day7;

use Test::More;

my $solution = AoC::Solution::Day7->new(
    input => "16,1,2,0,4,2,7,1,2,14",
);

is($solution->part_1, 37, 'part_1');
is($solution->part_2, 168, 'part_2');

done_testing();
