package AoC::Solution::Day10;

use Modern::Perl;

use Const::Fast;
use Moo;

with 'AoC::Solution';

const my $pairs => {
    '(' => ')',
    ')' => '(',
    '[' => ']',
    ']' => '[',
    '{' => '}',
    '}' => '{',
    '<' => '>',
    '>' => '<',
};

sub part_1 {
    my $self = shift;

    my %points = (
        ')' => 3,
        ']' => 57,
        '}' => 1197,
        '>' => 25137,
    );

    my $score;
    foreach my $line (@{ $self->input }) {
        my ($corrupt) = $self->_check_syntax($line);
        $score += $points{$corrupt} if $corrupt;
    }

    return $score;
}

sub part_2 {
    my $self = shift;

    my %points = (
        ')' => 1,
        ']' => 2,
        '}' => 3,
        '>' => 4,
    );

    my @scores;
    foreach my $line (@{ $self->input }) {
        my ($corrupt, $remaining) = $self->_check_syntax($line);

        next if $corrupt;

        my $completion = $self->_complete($remaining);

        my $score = 0;
        foreach my $char (@$completion) {
            $score *= 5;
            $score += $points{$char};
        }
        push @scores, $score;
    }

    @scores = sort { $a <=> $b } @scores;

    return $scores[int(@scores / 2)];
}

sub _check_syntax {
    my ($self, $line) = @_;

    my @seen;
    foreach my $char (@$line) {
        if ($char =~ /[\(\[{<]/) {
            unshift @seen, $char;
        }
        else {
            my $match = shift @seen;
            return ($char, \@seen) unless $pairs->{$match} eq $char;
        }
    }

    return (0, \@seen);
}

sub _complete {
    my ($self, $remaining) = @_;

    my @completion;
    foreach my $char (@$remaining) {
        push @completion, $pairs->{$char};
    }

    return \@completion;
}

sub _parse_input {
    my $self = shift;

    return [ map {
        [ split(//, $_) ]
    } split(/\n/, $self->input) ];
}

1;
