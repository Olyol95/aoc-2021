package AoC::Solution::Day4;

use Modern::Perl;

use AoC::Solution::Day4::Board;

use Clone qw(clone);
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $boards = $self->_boards;

    foreach my $draw (@{ $self->_draws }) {
        foreach my $board (@$boards) {
            $board->mark($draw);
            return $board->sum_unmarked * $draw
                if $board->has_bingo;
        }
    }

    return "No boards have reached bingo";
}

sub part_2 {
    my $self = shift;

    my $boards = $self->_boards;

    my $last_winning_draw;
    my $last_winning_board;

    foreach my $draw (@{ $self->_draws }) {
        foreach my $board (@$boards) {
            next if $board->has_bingo;
            $board->mark($draw);
            if ($board->has_bingo) {
                $last_winning_draw  = $draw;
                $last_winning_board = $board;
            }
        }
    }

    return $last_winning_board->sum_unmarked * $last_winning_draw;
}

sub _draws {
    my $self = shift;

    return [ split(/,/, $self->input->[0]) ];
}

sub _boards {
    my $self = shift;

    my @boards;

    my @current_board;
    for (my $idx = 2; $idx < @{ $self->input }; $idx++) {
        my $line = $self->input->[$idx];
        $line =~ s/^\s+//;

        push @current_board, [ split(/\s+/, $line) ] if $line;

        if (!$line || $idx == @{ $self->input } - 1) {
            push @boards, AoC::Solution::Day4::Board->new(
                values => clone(\@current_board),
            );
            @current_board = ();
        }
    }

    return \@boards;
}

1;
