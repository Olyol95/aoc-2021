package AoC::Solution;

use Modern::Perl;
use Moo::Role;

=head1 NAME

AoC::Solution

=head1 SYNOPSIS

  use Moo;

  with 'Aoc::Solution';

  sub part_1 {
      ...
  }

  sub part_2 {
      ...
  }

=head1 DESCRIPTION

Base role for solutions to the advent of code problems.

=head1 METHODS

=over

=item input( [VALUE] )

Get or set the input to be used for the solution

=cut

has input => (
    is       => 'ro',
    required => 1,
);

=item part_1

Returns the solution to part one of the problem

=cut

sub part_1 {
    return "Not implemented";
}

=item part_2

Returns the solution to part two of the problem

=cut

sub part_2 {
    return "Not implemented";
}

1;
