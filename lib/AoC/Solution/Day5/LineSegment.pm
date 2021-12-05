package AoC::Solution::Day5::LineSegment;

use Modern::Perl;

use List::Util qw(min max);
use Moo;

has 'start' => (
    is       => 'ro',
    required => 1,
);

has end => (
    is       => 'ro',
    required => 1,
);

has '_coefficients' => (
    is      => 'ro',
    lazy    => 1,
    builder => '_calculate_coefficients',
);

has '_intercept' => (
    is      => 'ro',
    lazy    => 1,
    builder => '_calculate_intercept',
);

sub points {
    my $self = shift;

    if ($self->is_vertical) {
        my $x = $self->start->[0];
        my $y_start = min($self->start->[1], $self->end->[1]);
        my $y_end   = max($self->start->[1], $self->end->[1]);
        return [ map {
            [ $x, $_ ]
        } $y_start ... $y_end ];
    }
    else {
        my $x_start = min($self->start->[0], $self->end->[0]);
        my $x_end   = max($self->start->[0], $self->end->[0]);
        return [ map {
            [ $_, $self->_y_value($_) ]
        } $x_start ... $x_end ];
    }
}

sub is_horizontal {
    my $self = shift;

    return $self->_coefficients->{x} == 0;
}

sub is_vertical {
    my $self = shift;

    return $self->_coefficients->{y} == 0;
}

sub is_diagonal {
    my $self = shift;

    my $c = $self->_coefficients;

    return abs($c->{y}) == abs($c->{x});
}

sub _y_value {
    my ($self, $x) = @_;

    my $c = $self->_coefficients;
    return ($self->_intercept + ($c->{x} * $x)) / $c->{y};
}

sub _calculate_coefficients {
    my $self = shift;

    my ($x1, $y1) = @{ $self->start };
    my ($x2, $y2) = @{ $self->end   };

    return {
        x => $y2 - $y1,
        y => $x2 - $x1,
    };
}

sub _calculate_intercept {
    my $self = shift;

    my $c = $self->_coefficients;
    my ($x, $y) = @{ $self->start };

    return ($c->{y} * $y) - ($c->{x} * $x);
}

1;
