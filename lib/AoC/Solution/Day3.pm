package AoC::Solution::Day3;

use Modern::Perl;
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $bit_weights = $self->_bit_weights($self->input);

    my $gamma = $self->_stringify([ map {
        $_ > 0 ? 1 : 0
    } @$bit_weights ]);

    my $epsilon = $self->_stringify([ map {
        $_ > 0 ? 0 : 1
    } @$bit_weights ]);

    return $self->_btoi($gamma) * $self->_btoi($epsilon);
}

sub part_2 {
    my $self = shift;

    my $oxygen_rating = $self->_stringify(
        $self->_filter_criteria(
            $self->input, 0, sub { $_ = shift; $_ >= 0 ? 1 : 0 },
        ),
    );

    my $carbon_rating = $self->_stringify(
        $self->_filter_criteria(
            $self->input, 0, sub { $_ = shift; $_ < 0 ? 1 : 0 },
        ),
    );

    return $self->_btoi($oxygen_rating) * $self->_btoi($carbon_rating);
}

sub _bit_weights {
    my ($self, $bit_seqs) = @_;

    my @bit_weights;
    foreach my $bit_seq (@$bit_seqs) {
        for (my $bit_idx = 0; $bit_idx < @$bit_seq; $bit_idx++) {
            my $value = $bit_seq->[$bit_idx];
            $bit_weights[$bit_idx] += $value ? 1 : -1;
        }
    }

    return \@bit_weights;
}

sub _filter_criteria {
    my ($self, $bit_seqs, $position, $criteria) = @_;

    my $bit_weights = $self->_bit_weights($bit_seqs);
    my $bit_value   = $criteria->($bit_weights->[$position]);

    my @filtered = grep {
        $_->[$position] == $bit_value
    } @$bit_seqs;

    if (@filtered > 1) {
        return $self->_filter_criteria(
            \@filtered,
            $position + 1,
            $criteria,
        );
    }
    else {
        return $filtered[0];
    }
}

sub _btoi {
    my ($self, $binary_str) = @_;

    return oct("0b$binary_str");
}

sub _stringify {
    my ($self, $bit_seq) = @_;

    return join('', @$bit_seq);
}

sub _parse_input {
    my $self = shift;

    my @input = map {
        [ split(//, $_) ]
    } split(/\n/, $self->input);

    return \@input;
}

1;
