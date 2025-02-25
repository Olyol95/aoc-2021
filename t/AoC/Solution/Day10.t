#!/usr/bin/env perl

use Modern::Perl;

use AoC::Solution::Day10;

use Test::More;

my $solution = AoC::Solution::Day10->new(
    input => join("\n", (
        '[({(<(())[]>[[{[]{<()<>>',
        '[(()[<>])]({[<{<<[]>>(',
        '{([(<{}[<>[]}>{[]{[(<()>',
        '(((({<>}<{<{<>}{[]{[]{}',
        '[[<[([]))<([[{}[[()]]]',
        '[{[{({}]{}}([{[{{{}}([]',
        '{<[[]]>}<{[{[{[]{()[[[]',
        '[<(<(<(<{}))><([]([]()',
        '<{([([[(<>()){}]>(<<{{',
        '<{([{{}}[<[[[<>{}]]]>[]]',
    )),
);

is($solution->part_1, 26397, 'part_1');
is($solution->part_2, 288957, 'part_2');

done_testing();
