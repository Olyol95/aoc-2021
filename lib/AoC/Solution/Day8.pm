package AoC::Solution::Day8;

use Modern::Perl;

use List::Util qw(sum);
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $total;
    foreach my $display (@{ $self->input }) {
        $total += grep {
            my $segments = keys %$_;
            $segments == 2
                || $segments == 3
                || $segments == 4
                || $segments == 7
        } @{ $display->{output} };
    }

    return $total;
}

sub part_2 {
    my $self = shift;

    return sum map {
        $self->_get_output_value(
            $_->{signals},
            $_->{output},
        )
    } @{ $self->input };
}

sub _get_output_value {
    my ($self, $signals, $output_signals) = @_;

    my %digit_to_signal;

    my @sorted_signals = sort {
        scalar keys %$a <=> scalar keys %$b
    } @$signals;

    foreach my $signal (@sorted_signals) {
        my $value;
        my $segments = keys %$signal;

        if ($segments == 2) {
            $value = 1;
        }
        elsif ($segments == 3) {
            $value = 7;
        }
        elsif ($segments == 4) {
            $value = 4;
        }
        elsif ($segments == 5) {
            # 2, 3 and 5 have 5 segments
            if ($self->_common_segments($signal, $digit_to_signal{4}) == 2) {
                # Only 2 shares 2 segments with 4
                $value = 2;
            }
            elsif ($self->_common_segments($signal, $digit_to_signal{1}) == 2) {
                # 3 shares 2 segments with 1
                $value = 3;
            }
            else {
                $value = 5;
            }
        }
        elsif ($segments == 6) {
            # 0, 6 and 9 have 6 segments
            if ($self->_common_segments($signal, $digit_to_signal{4}) == 4) {
                # Only 9 shares 4 segments with 4
                $value = 9;
            }
            elsif ($self->_common_segments($signal, $digit_to_signal{1}) == 2) {
                # 0 shares 2 segments with 1
                $value = 0;
            }
            else {
                $value = 6;
            }
        }
        elsif ($segments == 7) {
            $value = 8;
        }

        $digit_to_signal{$value} = $signal;
    }

    my %signal_to_digit = map {
        $self->_to_string($digit_to_signal{$_}) => $_
    } keys %digit_to_signal;

    my $output;
    foreach my $signal (@$output_signals) {
        $output .= $signal_to_digit{$self->_to_string($signal)};
    }
    return $output;
}

sub _common_segments {
    my ($self, $signal_1, $signal_2) = @_;

    return scalar grep {
        $signal_2->{$_}
    } keys %$signal_1;
}

sub _parse_input {
    my $self = shift;

    return [ map {
        my ($signals, $outputs) = split(/\s+\|\s+/, $_);
        {
            signals => [ map { $self->_to_signal($_) } split(/\s/, $signals) ],
            output  => [ map { $self->_to_signal($_) } split(/\s/, $outputs) ],
        }
    } split(/\n/, $self->input) ];
}

sub _to_signal {
    my ($self, $string) = @_;

    my %signal = map {
        $_ => 1
    } split(//, $string);

    return \%signal;
}

sub _to_string {
    my ($self, $signal) = @_;

    return join('', sort keys %$signal);
}

1;
