package AoC::Solution::Day9;

use Modern::Perl;

use List::Util qw(sum product first);
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return sum map {
        $self->_height_at(@$_) + 1
    } @{ $self->_local_minima };
}

sub part_2 {
    my $self = shift;

    my @basins = sort {
        scalar @{ $b->{points} } <=> scalar @{ $a->{points} }
    } @{ $self->_basins };

    return product map {
        scalar @{ $_->{points} }
    } @basins[0..2];
}

sub _basins {
    my $self = shift;

    my @basins;
    foreach my $minima (@{ $self->_local_minima }) {
        my $basin = {
            minima => $minima,
            points => [],
        };
        $self->_explore_basin($basin, @$minima);
        push @basins, $basin;
    }

    return \@basins;
}

sub _explore_basin {
    my ($self, $basin, $x, $y) = @_;

    my $height = $self->_height_at($x, $y);

    return if $height == 9
        || first { $_->[0] == $x && $_->[1] == $y } @{ $basin->{points} };

    push @{ $basin->{points} }, [ $x, $y ];

    $self->_explore_basin($basin, $x, $y - 1) if $y > 0;
    $self->_explore_basin($basin, $x, $y + 1) if $y < $self->_y_max;
    $self->_explore_basin($basin, $x - 1, $y) if $x > 0;
    $self->_explore_basin($basin, $x + 1, $y) if $x < $self->_x_max;
}

sub _local_minima {
    my $self = shift;

    my @minima;
    for (my $y = 0; $y <= $self->_y_max; $y++) {
        for (my $x = 0; $x <= $self->_x_max; $x++) {
            push @minima, [ $x, $y ]
                if $self->_is_local_minima($x, $y);
        }
    }

    return \@minima;
}

sub _is_local_minima {
    my ($self, $x, $y) = @_;

    my $height = $self->_height_at($x, $y);

    my $local_minima = 1;
    $local_minima &&= $self->_height_at($x, $y - 1) > $height if $y > 0;
    $local_minima &&= $self->_height_at($x, $y + 1) > $height if $y < $self->_y_max;
    $local_minima &&= $self->_height_at($x - 1, $y) > $height if $x > 0;
    $local_minima &&= $self->_height_at($x + 1, $y) > $height if $x < $self->_x_max;

    return $local_minima;
}

sub _height_at {
    my ($self, $x, $y) = @_;

    return $self->input->[$y]->[$x];
}

sub _y_max {
    my $self = shift;

    return @{ $self->input } - 1;
}

sub _x_max {
    my $self = shift;

    return @{ $self->input->[0] } - 1;
}

sub _parse_input {
    my $self = shift;

    return [ map {
        [ split(//, $_) ]
    } split(/\n/, $self->input) ];
}

1;
