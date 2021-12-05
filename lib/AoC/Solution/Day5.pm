package AoC::Solution::Day5;

use Modern::Perl;

use AoC::Solution::Day5::LineSegment;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my @clouds = grep {
        $_->is_horizontal || $_->is_vertical
    } @{ $self->input };

    return $self->_total_intersections(\@clouds);
}

sub part_2 {
    my $self = shift;

    my @clouds = grep {
        $_->is_horizontal || $_->is_vertical || $_->is_diagonal
    } @{ $self->input };

    return $self->_total_intersections(\@clouds);
}

sub _total_intersections {
    my ($self, $clouds) = @_;

    my %ocean_floor;
    foreach my $cloud (@$clouds) {
        foreach my $point (@{ $cloud->points }) {
            $ocean_floor{$point->[0]}->{$point->[1]}++;
        }
    }

    my $intersections = 0;
    foreach my $row (values %ocean_floor) {
        $intersections += grep { $_ > 1 } values %$row;
    }

    return $intersections;
}

sub _parse_input {
    my $self = shift;

    my @clouds;
    foreach my $line (split(/\n/, $self->input)) {
        next unless $line =~ /^(\d+),(\d+) -> (\d+),(\d+)$/;
        push @clouds, AoC::Solution::Day5::LineSegment->new(
            start => [$1, $2],
            end   => [$3, $4],
        );
    }

    return \@clouds;
}

1;
