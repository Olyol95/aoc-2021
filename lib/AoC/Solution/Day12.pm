package AoC::Solution::Day12;

use Modern::Perl;

use List::Util qw(first);
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $paths = $self->_traverse_caves_1('start');

    return scalar @$paths;
}

sub part_2 {
    my $self = shift;

    my $paths = $self->_traverse_caves_2(undef, 'start');

    return scalar @$paths;
}

sub _traverse_caves_1 {
    my ($self, @current_path) = @_;

    my $label = $current_path[-1];

    return [\@current_path] if $label eq 'end';

    my $node = $self->input->{$label};

    my @paths;
    foreach my $connection (@$node) {
        if ($connection =~ /^[A-Z]+$/ || !first { $_ eq $connection } @current_path) {
            push @paths, @{ $self->_traverse_caves_1(@current_path, $connection) };
        }
    }
    return \@paths;
}

sub _traverse_caves_2 {
    my ($self, $small_cave, @current_path) = @_;

    my $label = $current_path[-1];

    return [\@current_path] if $label eq 'end';

    my $node = $self->input->{$label};

    my @paths;
    foreach my $connection (@$node) {
        if ($connection =~ /^[A-Z]+$/) {
            push @paths, @{ $self->_traverse_caves_2($small_cave, @current_path, $connection) };
        }
        elsif ($connection ne 'start') {
            my $times_seen = grep { $_ eq $connection } @current_path;
            if ($times_seen) {
                if ($small_cave && $connection eq $small_cave && $times_seen == 1) {
                    push @paths, @{ $self->_traverse_caves_2($small_cave, @current_path, $connection) };
                }
                elsif (!$small_cave) {
                    push @paths, @{ $self->_traverse_caves_2($connection, @current_path, $connection) };
                }
            }
            else {
                push @paths, @{ $self->_traverse_caves_2($small_cave, @current_path, $connection) };
            }
        }
    }
    return \@paths;
}

sub _parse_input {
    my $self = shift;

    my %cave_system;
    foreach my $line (split(/\n/, $self->input)) {
        my ($node, $connection) = split(/-/, $line);
        push @{ $cave_system{$node} }, $connection;
        push @{ $cave_system{$connection} }, $node;
    }

    return \%cave_system;
}

1;
