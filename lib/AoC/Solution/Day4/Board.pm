package AoC::Solution::Day4::Board;

use Modern::Perl;

use Carp;
use List::Util qw(sum);
use Moo;

has 'width' => (
    is => 'ro',
    required => 1,
);

has 'height' => (
    is => 'ro',
    required => 1,
);

has '_value_locations' => (
    is      => 'ro',
    default => sub { {} },
);

has '_marked_values' => (
    is      => 'ro',
    default => sub { {} },
);

has '_mark_totals' => (
    is      => 'rw',
    default => sub {
        {
            col => {},
            row => {},
        }
    },
);

around BUILDARGS => sub {
    my ($orig, $class, %args) = @_;

    croak "No values provided" unless $args{values};

    my %locations;
    my $values = $args{values};

    for (my $y = 0; $y < @$values; $y++) {
        for (my $x = 0; $x < @{ $values->[$y] }; $x++) {
            my $value = $values->[$y]->[$x];
            $locations{$value} = {
                x => $x,
                y => $y,
            }
        }
    }

    return $class->$orig(
        width            => scalar @{ $values->[0] },
        height           => scalar @$values,
        _value_locations => \%locations,
    );
};

sub mark {
    my ($self, $value) = @_;

    croak "No value provided" unless defined $value;

    my $location = $self->_value_locations->{$value};

    return unless $location;

    $self->_marked_values->{$value} = 1;
    $self->_mark_totals->{col}->{$location->{x}}++;
    $self->_mark_totals->{row}->{$location->{y}}++;
}

sub has_bingo {
    my $self = shift;

    foreach my $col_idx (keys %{ $self->_mark_totals->{col} }) {
        return 1 if $self->_mark_totals->{col}->{$col_idx} == $self->height;
    }

    foreach my $row_idx (keys %{ $self->_mark_totals->{row} }) {
        return 1 if $self->_mark_totals->{row}->{$row_idx} == $self->width;
    }

    return 0;
}

sub sum_unmarked {
    my $self = shift;

    return sum(
        grep {
            !$self->_marked_values->{$_}
        } keys %{ $self->_value_locations }
    );
}

1;
