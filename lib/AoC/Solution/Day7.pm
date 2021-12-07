package AoC::Solution::Day7;

use Modern::Perl;
use List::Util qw(sum min);
use Moo;
use POSIX qw(ceil);

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my @positions = @{ $self->input };
    my $median = $positions[int (@positions / 2) - 1];

    return sum map {
        abs($median - $_)
    } @positions;
}

sub part_2 {
    my $self = shift;

    my @positions = @{ $self->input };
    my $average = sum(@positions) / @positions;

    # As the average may not be an integer, we need to
    # check both the upper and lower bound here
    my $cost_1 = $self->_part_2_fuel_cost(int($average));
    my $cost_2 = $self->_part_2_fuel_cost(ceil($average));

    return min($cost_1, $cost_2);
}

sub _part_2_fuel_cost {
    my ($self, $position) = @_;

    return sum map {
        my $dist = abs($position - $_);
        ($dist * ($dist + 1)) / 2;
    } @{ $self->input };
}

sub _parse_input {
    my $self = shift;

    return [
        sort {$a <=> $b}
        split(/,/, $self->input)
    ];
}

1;
