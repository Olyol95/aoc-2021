package AoC::Solution::Day2;

use Modern::Perl;

use AoC::Solution::Day2::Submarine;

use Carp;
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $sub = AoC::Solution::Day2::Submarine->new;

    foreach my $instr (@{ $self->input }) {
        if ($instr->{direction} eq 'forward') {
            $sub->impulse({ x => $instr->{magnitude} });
        }
        elsif ($instr->{direction} eq 'up') {
            $sub->impulse({ z => -$instr->{magnitude} });
        }
        elsif ($instr->{direction} eq 'down') {
            $sub->impulse({ z => $instr->{magnitude} });
        }
        else {
            carp "Encountered unknown direction '$instr->{direction}'";
        }
    }

    return $sub->location->{x} * $sub->location->{z};
}

sub part_2 {
    my $self = shift;

    my $sub = AoC::Solution::Day2::Submarine->new;

    foreach my $instr (@{ $self->input }) {
        if ($instr->{direction} eq 'forward') {
            $sub->impulse({
                x => $instr->{magnitude},
                z => $instr->{magnitude} * $sub->aim,
            });
        }
        elsif ($instr->{direction} eq 'up') {
            $sub->aim($sub->aim - $instr->{magnitude});
        }
        elsif ($instr->{direction} eq 'down') {
            $sub->aim($sub->aim + $instr->{magnitude});
        }
        else {
            carp "Encountered unknown direction '$instr->{direction}'";
        }
    }

    return $sub->location->{x} * $sub->location->{z};
}

sub _parse_input {
    my $self = shift;

    my @instructions = map {
        my ($direction, $magnitude) = split(/\s+/, $_);
        {
            direction => $direction,
            magnitude => $magnitude,
        }
    } split(/\n/, $self->input);

    return \@instructions;
}

1;
