package AoC::Solution::Day1;

use Modern::Perl;
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my @readings = @{ $self->input };

    my $total_increases = 0;
    for (my $idx = 1; $idx < @readings; $idx++) {
        if ($readings[$idx] > $readings[$idx - 1]) {
            $total_increases++;
        }
    }

    return $total_increases;
}

sub part_2 {
    my $self = shift;

    my @readings = @{ $self->input };

    my $prev_sum = 0;
    my $total_increases = 0;

    for (my $idx = 1; $idx < @readings - 1; $idx++) {
        my $curr_sum = $readings[$idx - 1]
            + $readings[$idx]
            + $readings[$idx + 1];

        if ($prev_sum && $curr_sum > $prev_sum) {
            $total_increases++;
        }

        $prev_sum = $curr_sum;
    }

    return $total_increases;
}

1;
