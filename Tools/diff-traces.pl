#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

sub get_trace_from_file {
    my $trace_file = shift;

    open(my $trace_fh, '<', $trace_file) or die "Cannot open $trace_file for reading\n";

    my $trace = {};

    my $current_key;
    while (my $line = <$trace_fh>) {
        chomp($line);

        $current_key = $1 if ($line =~ m/SF:(.*)/);
        $trace->{$current_key}->{$1} = undef if ($line =~ m/DA:([0-9]+),[1-9]+/);
    }

    close($trace_fh);

    return $trace;
}

sub diff_traces {
    my $static_trace = shift;
    my $dynamic_trace = shift;

    foreach my $dynamic_file (keys %{$dynamic_trace}) {
        next unless exists($static_trace->{$dynamic_file});

        foreach my $dynamic_line (keys %{$dynamic_trace->{$dynamic_file}}) {
            next unless exists($static_trace->{$dynamic_file}->{$dynamic_line});

            delete $static_trace->{$dynamic_file}->{$dynamic_line};
        }
    }
}

sub write_diff {
    my $diff_trace = shift;
    my $diff_trace_file = shift;

    open(my $diff_trace_fh, '>', $diff_trace_file) or die "Cannot open $diff_trace_file for writing\n";

    foreach my $file (keys %{$diff_trace}) {
        next unless keys %{$diff_trace->{$file}};

        print $diff_trace_fh "SF:${file}\n";

        foreach my $line_number (keys %{$diff_trace->{$file}}) {
            print $diff_trace_fh "DA:${line_number},0\n";
        }

        print $diff_trace_fh "end_of_record\n";
    }

    close($diff_trace_fh);
}

# BEGIN CONFIG#

my $diff_trace_file = "diff-" . time() . "-trace.txt";

# END CONFIG#

die "Usage: $0 <path_to_static_trace> <path_to_dynamic_trace>\n" if @ARGV != 2;

my $static_trace_file = shift(@ARGV);
my $dynamic_trace_file = shift(@ARGV);

my $static_trace = get_trace_from_file($static_trace_file);
my $dynamic_trace = get_trace_from_file($dynamic_trace_file);

#print Dumper $static_trace;
#print Dumper $dynamic_trace;

diff_traces($static_trace, $dynamic_trace);

write_diff($static_trace, $diff_trace_file);

