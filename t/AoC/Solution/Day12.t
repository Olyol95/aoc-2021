#!/usr/bin/env perl

use Modern::Perl;

use AoC::Solution::Day12;

use Test::More;

my $solution = AoC::Solution::Day12->new(
    input => join("\n", (
        'start-A',
        'start-b',
        'A-c',
        'A-b',
        'b-d',
        'A-end',
        'b-end',
    )),
);

is($solution->part_1, 10, 'part_1_a');
is($solution->part_2, 36, 'part_2_a');

$solution = AoC::Solution::Day12->new(
    input => join("\n", (
        'dc-end',
        'HN-start',
        'start-kj',
        'dc-start',
        'dc-HN',
        'LN-dc',
        'HN-end',
        'kj-sa',
        'kj-HN',
        'kj-dc',
    )),
);

is($solution->part_1, 19, 'part_1_b');
is($solution->part_2, 103, 'part_2_b');

$solution = AoC::Solution::Day12->new(
    input => join("\n", (
        'fs-end',
        'he-DX',
        'fs-he',
        'start-DX',
        'pj-DX',
        'end-zg',
        'zg-sl',
        'zg-pj',
        'pj-he',
        'RW-he',
        'fs-DX',
        'pj-RW',
        'zg-RW',
        'start-pj',
        'he-WI',
        'zg-he',
        'pj-fs',
        'start-RW',
    )),
);

is($solution->part_1, 226, 'part_1_c');
is($solution->part_2, 3509, 'part_2_c');

done_testing();
