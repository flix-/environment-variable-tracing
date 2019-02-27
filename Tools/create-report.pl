#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

# BEGIN CONFIG #

my $diff_trace_file = "diff-" . time() . "-trace.txt";
my $report_file = "report-" . time() . ".txt";

my $skip_file_pattern = "/home/sebastian/.qt-creator-workspace/Phasar/Sample/src/test";

my $print_summary_only = 0;

# END CONFIG #

die "Usage: $0 <path_to_static_trace> <path_to_dynamic_trace>\n" if @ARGV != 2;

my $static_trace_file = shift(@ARGV);
my $dynamic_trace_file = shift(@ARGV);

my $static_trace = get_trace_from_file($static_trace_file);
my $dynamic_trace = get_trace_from_file($dynamic_trace_file);

#print Dumper $static_trace;
#print Dumper $dynamic_trace;

# create / write report
print "Writing report to: $report_file\n";
write_report($static_trace, $dynamic_trace, $report_file);

# create diff

create_diff($static_trace, $dynamic_trace);

#print Dumper $static_trace;

print "Writing diff to: $diff_trace_file\n";
write_diff($static_trace, $diff_trace_file);


sub get_trace_from_file {
    my $trace_file = shift;

    open(my $trace_fh, '<', $trace_file) or die "Cannot open $trace_file for reading\n";

    my $trace = {};

    my $current_key;
    while (my $line = <$trace_fh>) {
        chomp($line);

        if ($line =~ m/SF:(.*)/) {
            $current_key = $1;
            next;
        }

        next if (!$current_key || ($current_key =~ m/$skip_file_pattern/));
        
        $trace->{$current_key} = undef unless (exists ${trace}->{$current_key});

        $trace->{$current_key}->{"FNDA"}->{$2} = $1 if ($line =~ m/FNDA:([0-9]+),(.*)/);
        $trace->{$current_key}->{"DA"}->{$1} = $2 if ($line =~ m/DA:([0-9]+),([0-9]+)/);
    }

    close($trace_fh);

    return $trace;
}

sub write_report {
    my $static_trace = shift;
    my $dynamic_trace = shift;
    my $report_file = shift;

    open(my $report_fh, '>', $report_file) or die "Cannot open $report_file for writing\n";

    print $report_fh "#########\n";
    print $report_fh "# FILES #\n";
    print $report_fh "#########\n\n"; 

    print $report_fh "Files dependent on environment variables\n" unless $print_summary_only;
    print $report_fh "========================================\n" unless $print_summary_only;

    foreach my $file (sort keys %{$static_trace}) {
        print $report_fh "$file\n" unless $print_summary_only;
    }

    print $report_fh "\n" unless $print_summary_only;

    print $report_fh "Files total\n" unless $print_summary_only;
    print $report_fh "===========\n" unless $print_summary_only;

    foreach my $file (sort keys %{$dynamic_trace}) {
        print $report_fh "$file\n" unless $print_summary_only;
    }

    print $report_fh "\n" unless $print_summary_only;

    print $report_fh "Files summary\n";
    print $report_fh "=============\n";

    print $report_fh "\n";

    my $static_total_files = keys %{$static_trace};
    my $dynamic_total_files = keys %{$dynamic_trace};
    my $files_ratio = $static_total_files / $dynamic_total_files;

    print $report_fh "Files dependent on environment variables: $static_total_files\n";
    print $report_fh "Files total: $dynamic_total_files\n";
    print $report_fh "Files dependent / Files total: $files_ratio\n";

    print $report_fh "\n";

    print $report_fh "#############\n";
    print $report_fh "# FUNCTIONS #\n";
    print $report_fh "#############\n\n"; 

    print $report_fh "Functions dependent on environment variables\n" unless $print_summary_only;
    print $report_fh "============================================\n" unless $print_summary_only;

    my $static_total_functions = 0;
    foreach my $file (sort keys %{$static_trace}) {
        print $report_fh "$file\n" unless $print_summary_only;

        foreach my $function (sort keys %{$static_trace->{$file}->{"FNDA"}}) {
            print $report_fh "$function\n" unless $print_summary_only;

            $static_total_functions++;
        }
        print $report_fh "\n" unless $print_summary_only;
    }

    print $report_fh "Functions total\n" unless $print_summary_only;
    print $report_fh "===============\n" unless $print_summary_only;

    my $dynamic_total_functions = 0;
    foreach my $file (sort keys %{$dynamic_trace}) {
        print $report_fh "$file\n" unless $print_summary_only;

        foreach my $function (sort keys %{$dynamic_trace->{$file}->{"FNDA"}}) {
            print $report_fh "$function\n" unless $print_summary_only;

            $dynamic_total_functions++;
        }
        print $report_fh "\n" unless $print_summary_only;
    }

    print $report_fh "Functions summary\n";
    print $report_fh "=================\n";

    print $report_fh "\n";

    my $functions_ratio = $static_total_functions / $dynamic_total_functions;

    print $report_fh "Functions dependent on environment variables: $static_total_functions\n";
    print $report_fh "Functions total: $dynamic_total_functions\n";
    print $report_fh "Functions dependent / Functions total: $functions_ratio\n";

    print $report_fh "\n";

    print $report_fh "#################\n";
    print $report_fh "# LINES OF CODE #\n";
    print $report_fh "#################\n\n"; 

    print $report_fh "Lines of code dependent on environment variables\n" unless $print_summary_only;
    print $report_fh "================================================\n" unless $print_summary_only;

    my $static_total_loc = 0;
    foreach my $file (sort keys %{$static_trace}) {
        print $report_fh "$file\n" unless $print_summary_only;

        foreach my $loc (sort {$a <=> $b} keys %{$static_trace->{$file}->{"DA"}}) {
            print $report_fh "$loc\n" unless $print_summary_only;

            $static_total_loc++;
        }
        print $report_fh "\n" unless $print_summary_only;
    }

    print $report_fh "Lines of code total\n" unless $print_summary_only;
    print $report_fh "===================\n" unless $print_summary_only;

    my $dynamic_total_loc = 0;
    foreach my $file (sort keys %{$dynamic_trace}) {
        print $report_fh "$file\n" unless $print_summary_only;

        foreach my $loc (sort {$a <=> $b} keys %{$dynamic_trace->{$file}->{"DA"}}) {
            print $report_fh "$loc\n" unless $print_summary_only;

            $dynamic_total_loc++;
        }
        print $report_fh "\n" unless $print_summary_only;
    }

    print $report_fh "Lines of code summary\n";
    print $report_fh "=====================\n";

    print $report_fh "\n";

    my $loc_ratio = $static_total_loc / $dynamic_total_loc;

    print $report_fh "Lines of code dependent on environment variables: $static_total_loc\n";
    print $report_fh "Lines of code total: $dynamic_total_loc\n";
    print $report_fh "Lines of code dependent / Lines of code total: $loc_ratio\n";

    print $report_fh "\n";

    close($report_fh);
}

sub create_diff {
    my $static_trace = shift;
    my $dynamic_trace = shift;

    foreach my $dynamic_file (keys %{$dynamic_trace}) {
        next unless exists($static_trace->{$dynamic_file});

        foreach my $dynamic_loc (keys %{$dynamic_trace->{$dynamic_file}->{"DA"}}) {
            next unless ($dynamic_trace->{$dynamic_file}->{"DA"}->{$dynamic_loc} > 0);

            next unless exists($static_trace->{$dynamic_file}->{"DA"}->{$dynamic_loc});

            delete $static_trace->{$dynamic_file}->{"DA"}->{$dynamic_loc};
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

        foreach my $loc (keys %{$diff_trace->{$file}->{"DA"}}) {
            print $diff_trace_fh "DA:${loc},0\n";
        }

        print $diff_trace_fh "end_of_record\n";
    }

    close($diff_trace_fh);
}
#EOF

