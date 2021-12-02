package AoC::Solution::Day2::Submarine;

use Modern::Perl;

use Carp;
use Const::Fast;
use Moo;

has aim => (
    is       => 'rw',
    required => 1,
    default  => 0,
);

has location => (
    is       => 'rw',
    required => 1,
    default  => sub {
        {
            x => 0,
            z => 0,
        }
    },
);

sub impulse {
    my ($self, $vector) = @_;

    croak "No vector provided" unless $vector;

    foreach my $component (keys %$vector) {
        $self->location->{$component} += $vector->{$component};
    }
}

1;
