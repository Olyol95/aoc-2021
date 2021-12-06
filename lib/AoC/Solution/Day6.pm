package AoC::Solution::Day6;

use Modern::Perl;

use Const::Fast;
use List::Util qw(sum);
use Moo;

with 'AoC::Solution';

const my $DAYS_TO_REPRODUCE => 7;
const my $DAYS_TO_MATURE    => 2;

sub part_1 {
    my $self = shift;

    return $self->_total_fish_after(80);
}

sub part_2 {
    my $self = shift;

    return $self->_total_fish_after(256);
}

sub _total_fish_after {
    my ($self, $days) = @_;

    my @school = @{ $self->input };
    foreach my $day (1 .. $days) {
        my $ready_fish = shift @school;
        $school[$DAYS_TO_REPRODUCE - 1] += $ready_fish;
        push @school, $ready_fish;
    }

    return sum @school;
}

sub _parse_input {
    my $self = shift;

    my $age_str = $self->input;
    chomp $age_str;

    my @school;
    foreach my $age (split(/,/, $age_str)) {
        $school[$age]++;
    }

    my $max_age = $DAYS_TO_REPRODUCE + $DAYS_TO_MATURE;
    for (my $age = 0; $age < $max_age; $age++) {
        $school[$age] = 0 unless $school[$age];
    }

    return \@school;
}

1;
