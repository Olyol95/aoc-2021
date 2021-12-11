package AoC::Solution::Day11;

use Modern::Perl;

use Clone qw(clone);
use List::Util qw(min max sum);
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $state = clone $self->input;

    return sum map {
        $self->_step($state)
    } (1..100);
}

sub part_2 {
    my $self = shift;

    my $state = clone $self->input;

    my $step = 0;
    while (++$step) {
        my $flashes = $self->_step($state);
        last if $flashes == ($self->_x_max + 1) * ($self->_y_max + 1);
    }

    return $step;
}

sub _step {
    my ($self, $state) = @_;

    my $total_flashes = 0;

    my %flashing;
    for (my $y = 0; $y <= $self->_y_max; $y++) {
        for (my $x = 0; $x <= $self->_x_max; $x++) {
            $state->[$y]->[$x]++;
            if ($state->[$y]->[$x] > 9) {
                $self->_propagate_flash($state, \%flashing, $x, $y);
            }
        }
    }
    foreach my $y (keys %flashing) {
        foreach my $x (keys %{ $flashing{$y} }) {
            $state->[$y]->[$x] = 0;
            $total_flashes++;
        }
    }

    return $total_flashes;
}

sub _propagate_flash {
    my ($self, $state, $flashing, $x, $y) = @_;

    return if $flashing->{$y}->{$x};

    $flashing->{$y}->{$x} = 1;

    for (my $dy = max(0, $y - 1); $dy <= min($self->_y_max, $y + 1); $dy++) {
        for (my $dx = max(0, $x - 1); $dx <= min($self->_x_max, $x + 1); $dx++) {
            next if $dy == $y && $dx == $x;
            $state->[$dy]->[$dx]++;
            if ($state->[$dy]->[$dx] > 9) {
                $self->_propagate_flash($state, $flashing, $dx, $dy);
            }
        }
    }
}

sub _x_max {
    my $self = shift;

    return scalar @{ $self->input->[0] } - 1;
}

sub _y_max {
    my $self = shift;

    return scalar @{ $self->input } - 1;
}

sub _parse_input {
    my $self = shift;

    return [ map {
        [ split(//, $_) ]
    } split(/\n/, $self->input) ];
}

1;
